import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pagination_prac/controllers/cubits/user_data_cubit/user_data_pagination_cubit.dart';
import 'package:pagination_prac/models/user_data_model/user_data_model.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 1);
  int page = 0;

  @override
  void initState() {
    page = 1;
    _pagingController.addPageRequestListener((pageKey) {
      context.read<UserDataPaginationCubit>().getUserData(pageKey);
      print(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: BlocConsumer<UserDataPaginationCubit, UserDataPaginationState>(
        listener: (context, state) {
          if (state is UserDataPaginationLoaded) {
            print("loaded");
            if (page < state.allUserData.total / 10) {
              _pagingController.appendPage(state.allUserData.users, ++page);
            } else {
              _pagingController.appendLastPage(state.allUserData.users);
            }
          }
        },
        builder: (context, state) {
          return PagedListView(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                  noItemsFoundIndicatorBuilder: (context) =>
                      const Text("No more data"),
                  itemBuilder: (context, userData, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 15),
                      child: Container(
                        height: 150,
                        width: 200,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CircleAvatar(
                                      radius: 50,
                                      child: Image.network(
                                        userData.image,
                                        fit: BoxFit.fill,
                                      ))),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Align(
                                      child: Text(
                                        "First Name: ${userData.firstName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                    Expanded(
                                        child: Align(
                                      child: Text(
                                          'Last Name: ${userData.lastName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )),
                                    Expanded(
                                        child: Align(
                                            child: Text(
                                                "Email: ${userData.email}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
        },
      ),
    );
  }
}
