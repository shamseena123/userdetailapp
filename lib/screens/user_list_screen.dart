import 'package:flutter/material.dart';
import 'package:user_details_app/screens/user_detail_screen.dart';
import '../models/user_model.dart';
import '../services/api_services.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];

  String searchQuery = "";
  String selectedCompany = "Company";
  bool isAscending = true;
  bool isLoading = true;
  String sortOption = "Default";

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final users = await ApiServices().fetchUsers();

    setState(() {
      allUsers = users;
      filteredUsers = users;
      isLoading = false;
    });
  }

  void applyFilters() {
    List<UserModel> users = List.from(allUsers);

    if (searchQuery.isNotEmpty) {
      users = users.where((user) {
        return user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedCompany != "All" && selectedCompany != "Company") {
      users = users
          .where((user) => user.company.name == selectedCompany)
          .toList();
    }

    if (sortOption == "A-Z") {
      users.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortOption == "a-z") {
      users.sort((a, b) => b.name.compareTo(a.name));
    }
    setState(() {
      filteredUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              "USERS",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.people, size: 28, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 320,

                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "search name or email",
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),

                                  onPressed: () {
                                    setState(() {
                                      searchQuery = "";
                                    });

                                    applyFilters();
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),

                            borderSide: const BorderSide(width: 2.5),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 2.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 3),
                          ),
                        ),

                        onChanged: (value) {
                          searchQuery = value;
                          applyFilters();
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      "${filteredUsers.length} user found",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      DropdownButton<String>(
                        value: selectedCompany,

                        items:
                            [
                              "Company",
                              "All",
                              ...allUsers
                                  .map((user) => user.company.name)
                                  .toSet()
                                  .toList(),
                            ].map((company) {
                              return DropdownMenuItem(
                                value: company,
                                child: Text(company),
                              );
                            }).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedCompany = value!;
                          });
                          applyFilters();
                        },
                      ),

                      DropdownButton<String>(
                        value: sortOption,

                        items: ["Default", "A-Z", "Z-A"].map((item) {
                          return DropdownMenuItem(
                            value: item,

                            child: Text("Sort:$item"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            sortOption = value!;
                          });
                          applyFilters();
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: fetchUsers,
                    child: filteredUsers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 80,
                                  color: Colors.grey,
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "No user found",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 10),

                                Text(
                                  "Try changing search or filter",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredUsers.length,

                            itemBuilder: (context, index) {
                              final user = filteredUsers[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),

                                child: Card(
                                  elevation: 4,
                                  color: Colors.green.shade100,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(12),

                                    leading: CircleAvatar(
                                      child: Text(user.name[0]),
                                    ),

                                    title: Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    subtitle: Text(user.email),

                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                    ),

                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetailScreen(user: user),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
