part of 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';

mixin AddUserViweModel on State<AddUsetIteam> {
  final _dateFormKey = GlobalKey<FormState>();
  File? images;
  DateTime selectedDate = DateTime.now();
  ValueNotifier isChanged = ValueNotifier(false);

  ValueNotifier<bool> isDis = ValueNotifier(false);

  bool get isDisabled =>
      widget.vm.name.text.isEmpty ||
      widget.vm.gender.text.isEmpty ||
      widget.vm.latname.text.isEmpty ||
      widget.vm.age.text.isEmpty;

  @override
  void initState() {
    super.initState();
    if (isChanged.value) {
      changeInfo();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.vm.age.text = MyFunctions.formattedDate(selectedDate);
    }
  }

  checkOrder(String username) {
    context.read<AccountsBloc>().add(
          CheckOrderEvent(
            username: username,
            onSucces: () {},
            onSuccesOrder: (entity) {
              final bloc = context.read<CartBloc>();
              final blocNav = context.read<MyNavigatorBloc>();
              final blocAccount = context.read<AccountsBloc>();
              final tashkilot = context
                  .read<AuthenticationBloc>()
                  .state
                  .listSpecial
                  .where((element) =>
                      element.id ==
                      StorageRepository.getString(StorageKeys.SPID))
                  .first
                  .org
                  .name;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: context.color.contColor,
                  content: ChechOrderDialog(
                    bloc: bloc,
                    tashkilot: tashkilot,
                    orders: entity,
                    blocAccount: blocAccount,
                    blocNavigator: blocNav,
                  ),
                ),
              );
            },
            onError: () {
              context.read<MyNavigatorBloc>().add(NavId(0));
            },
            onErrorOrder: () {
              context.read<MyNavigatorBloc>().add(NavId(0));
            },
          ),
        );
  }

  changeInfo() {
    isDis.value = !isDisabled;
    if (!isChanged.value) {
      isChanged.value = true;
    }
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  updateAccount(String username) {
    final data = {
      "name": widget.vm.name.text,
      "surname": widget.vm.surname.text,
      "lastname": widget.vm.latname.text,
      "gender": widget.vm.gender.text,
      "birthday": isToday(selectedDate)
          ? MyFunctions.formatDate2(widget.vm.age.text)
          : MyFunctions.ageDate(selectedDate),
      "nationality": widget.vm.nationality.text,
      "position": widget.vm.birthPlace.text,
      "current_place": widget.vm.currentPlace.text,
      "education": MyFunctions.information(widget.vm.information.text)
    };
    if (widget.vm.regionEntity?.id != null) {
      data["region"] = widget.vm.regionEntity!.id.toString();
    }
    if (widget.vm.professionEntity?.id != null) {
      data["main_cat"] = widget.vm.professionEntity!.id.toString();
    }

    context.read<AccountsBloc>().add(UpdateAccountEvent(
          username: username,
          data: data,
          onSucces: (account) {
            widget.vm.selectAccount(account, false);
          },
        ));
  }

  createUser() async {
    // widget.vm.createAccount(context, images);

    FormData formData = widget.vm.phone.text[0] == "+"
        ? FormData.fromMap({
            "name": widget.vm.name.text,
            "surname": widget.vm.surname.text,
            "lastname": widget.vm.latname.text,
            "gender": widget.vm.gender.text,
            "main_cat": widget.vm.professionEntity?.id,
            "birthday": isToday(selectedDate)
                ? widget.vm.age.text.split('/').reversed.join('-')
                : MyFunctions.ageDate(selectedDate),
            "region": widget.vm.regionEntity?.id,
            "pvc": "000000",
            "is_afgan": widget.vm.isAfgan.value,
            "is_cherno": widget.vm.isCherno.value,
            "is_invalid": widget.vm.isInvalid.value,
            "is_uvu": widget.vm.isUvu.value,
            "position": widget.vm.birthPlace.text,
            "phone": widget.vm.phone.text.substring(1),
            "nationality": widget.vm.nationality.text,
            "current_place": widget.vm.currentPlace.text,
            "education": MyFunctions.information(widget.vm.information.text),
            "type": "user",
            "avatar": images != null
                ? await MultipartFile.fromFile(images!.path)
                : images
          })
        : FormData.fromMap({
            "name": widget.vm.name.text,
            "surname": widget.vm.surname.text,
            "lastname": widget.vm.latname.text,
            "gender": widget.vm.gender.text,
            "main_cat": widget.vm.professionEntity?.id,
            "birthday": isToday(selectedDate)
                ? widget.vm.age.text.split('/').reversed.join('-')
                : MyFunctions.ageDate(selectedDate),
            "region": widget.vm.regionEntity?.id,
            "pvc": "000000",
            "is_afgan": widget.vm.isAfgan.value,
            "is_cherno": widget.vm.isCherno.value,
            "is_invalid": widget.vm.isInvalid.value,
            "is_uvu": widget.vm.isUvu.value,
            "position": widget.vm.birthPlace.text,
            "pinfl": widget.vm.phone.text,
            "nationality": widget.vm.nationality.text,
            "current_place": widget.vm.currentPlace.text,
            "education": MyFunctions.information(widget.vm.information.text),
            "type": "user",
            "avatar": images != null
                ? await MultipartFile.fromFile(images!.path)
                : images
          });

    // ignore: use_build_context_synchronously
    context.read<AccountsBloc>().add(
          CreateAccount(
            formData: formData,
            onSucces: () {
              widget.vm.isCreat = false;
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                    message: "User Yaratildi",
                    status: PopStatus.success,
                  ));
              context.read<MyNavigatorBloc>().add(NavId(1));
              widget.vm.controller.text =
                  "${widget.vm.name.text} ${widget.vm.latname.text} ${widget.vm.age.text} ${widget.vm.gender.text}";
              context.pop();
            },
            onError: () {
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                  message: "User Yaratilmadi", status: PopStatus.error));
            },
          ),
        );
  }

  cuponSelText(List<CuponModel> cupons) {
    widget.vm.cupon.text = cupons.map((e) => e.title).toList().join(', ');
  }

  getRegionDialog(AccountsBloc bloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.color.backGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider.value(
          value: bloc,
          child: RegionDialog(vm: widget.vm),
        ),
      ),
    ).then((value) {
      if (value is RegionEntity) {
        widget.vm.region.text = value.name;
        widget.vm.regionEntity = value;
        changeInfo();
        setState(() {});
      }
    });
  }

  getCuponDialog(List<CuponModel> cupons, String username, AccountsBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: context.color.backGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider.value(
          value: bloc,
          child: CuponDialog(
            vm: widget.vm,
            cupons: cupons,
            username: username,
          ),
        ),
      ),
    ).then((value) {
      setState(() {});
    });
  }

  getProfissonDialog(AccountsBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: context.color.backGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider.value(
          value: bloc,
          child: ProfessionDialog(vm: widget.vm),
        ),
      ),
    ).then((value) {
      if (value is ProfessionEntity) {
        widget.vm.profession.text = value.name;
        widget.vm.professionEntity = value;
        changeInfo();
        setState(() {});
      }
    });
  }

  getSelectionImage() {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isMacOS) {
          return const WCameraDialogMacos();
        }
        if (Platform.isWindows) {
          return AlertDialog(
            backgroundColor: context.color.backGroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            content: const UserCamer(),
          );
        }
        return const Center(
          child: Text("Platform isn't right"),
        );
      },
    ).then((value) {
      if (value != null) {
        if (value is File) {
          images = value;
          changeInfo();
          setState(() {});
        }
      }
    });
    setState(() {});
  }

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  String errorMessage = '';

  void _onDateChanged(String value) {
    try {
      if (value.length == 10) {
        // DateTime inputDate = _dateFormat.parseStrict(value);
        setState(() {
          errorMessage = '';
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      String formattedNow = _dateFormat.format(now);
      setState(() {
        widget.vm.age.text = formattedNow;
        errorMessage =
            'Noto\'g\'ri sana kiritildi. Hozirgi sana: $formattedNow';
        widget.vm.age.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.vm.age.text.length),
        );
      });
    }
  }

  DateTime? parseDate(String inputDate) {
    if (inputDate.isNotEmpty) {
      try {
        final datetime = DateFormat('dd/MM/yyyy').parseStrict(inputDate);
        if (!datetime.isAfter(DateTime.now())) {
          selectedDate = datetime;
          return datetime;
        } else {
          return null;
        }
      } catch (e) {
        return null; // Return null for invalid dates
      }
    }
    return null; // Return null for invalid dates
  }
}
