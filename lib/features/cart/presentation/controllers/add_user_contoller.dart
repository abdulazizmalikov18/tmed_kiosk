part of 'package:tmed_kiosk/features/cart/presentation/widgets/add_user_iteam.dart';

mixin AddUserViweModel on State<AddUsetIteam> {
  final _dateFormKey = GlobalKey<FormState>();
  File? images;
  DateTime selectedDate = DateTime.now();
  bool isChanged = false;
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

  changeInfo() {
    if (!isChanged) {
      isChanged = true;
      setState(() {});
    }
  }

  createUser() async {
    // widget.vm.createAccount(context, images);
    FormData formData = widget.vm.phone.text[0] == "+"
        ? FormData.fromMap({
            "name": widget.vm.name.text,
            "gender": widget.vm.gender.text,
            "profession": widget.vm.professionEntity?.id,
            "lastname": widget.vm.latname.text,
            "birthday": MyFunctions.ageDate(selectedDate),
            "region": widget.vm.regionEntity?.id,
            "pvc": "000000",
            "phone": widget.vm.phone.text.substring(1),
            "surname": widget.vm.latname.text,
            "avatar": images != null
                ? await MultipartFile.fromFile(images!.path)
                : images
          })
        : FormData.fromMap({
            "name": widget.vm.name.text,
            "gender": widget.vm.gender.text,
            "profession": widget.vm.professionEntity?.id,
            "lastname": widget.vm.latname.text,
            "birthday": MyFunctions.ageDate(selectedDate),
            "region": widget.vm.regionEntity?.id,
            "pvc": "000000",
            "pinfl": widget.vm.phone.text,
            "surname": widget.vm.latname.text,
            "avatar": images != null
                ? await MultipartFile.fromFile(images!.path)
                : images
          });

    // ignore: use_build_context_synchronously
    context.read<AccountsBloc>().add(
          CreateAccount(
            formData: formData,
            onSucces: () {
              widget.vm.isCreat = true;
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                    message: "User Yaratildi",
                    status: PopStatus.success,
                  ));
              context.read<MyNavigatorBloc>().add(NavId(1));
              widget.vm.controller.text =
                  "${widget.vm.name.text} ${widget.vm.latname.text}";
            },
            onError: () {
              context.read<ShowPopUpBloc>().add(ShowPopUp(
                  message: "User Yaratilmadi", status: PopStatus.error));
            },
          ),
        );
  }

  cuponSelText(List<CuponEntity> cupons) {
    widget.vm.cupon.text = cupons.map((e) => e.title).toList().join(', ');
  }

  getRegionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider(
          create: (context) => AccountsBloc(),
          child: RegionDialog(vm: widget.vm),
        ),
      ),
    ).then((value) {
      if (value is RegionEntity) {
        widget.vm.region.text = value.name;
        widget.vm.regionEntity = value;
        setState(() {});
      }
    });
  }

  getCuponDialog(List<CuponEntity> cupons, String username) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider(
          create: (context) => AccountsBloc(),
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

  getProfissonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        content: BlocProvider(
          create: (context) => AccountsBloc(),
          child: ProfessionDialog(vm: widget.vm),
        ),
      ),
    ).then((value) {
      if (value is ProfessionEntity) {
        widget.vm.profession.text = value.name;
        widget.vm.professionEntity = value;
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
          setState(() {});
        }
      }
    });
    setState(() {});
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
