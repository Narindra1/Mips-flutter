import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/configurations/colors_list.dart';
import 'package:MIPS/presentation/configurations/extension_for_localization.dart';
import 'package:MIPS/presentation/screens/base/base_screen.dart';
import 'package:MIPS/presentation/screens/exchange_rate/bloc/exchange_rate_bloc.dart';
import 'package:MIPS/presentation/widgets/loading_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:ionicons/ionicons.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  final _calculationController = TextEditingController();
  bool vertical = false;
  double a = 4465.78;
  double b = 5083.74;
  double c = 7.1154;
  double d = 88.6712;
  double e = 1468.62;

  int? _value = 2;
  double _ariary = 0.0;
  double _dollars = 0.0;
  double _euros = 0.0;
  double _yuans = 0.0;
  double _rupees = 0.0;
  double _wons = 0.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<String> operations = ["Ar", "\$", "€", "CN ¥", "₹", "₩"];

    return BaseScreen(
      useDefaultAnnonceSponsPart: true,
      content: BlocProvider(
        create: (context) =>
            GetIt.instance<ExchangeRateBloc>()..add(ExchangeRateLoaded()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
                    builder: (context, state) {
                      return Text(
                        AppUtils.formatTodaysDate(
                            context, state.date.toString()),
                        style: textTheme.titleSmall,
                      );
                    },
                  ),
                ),
              ),
              // const SizedBox(height: smallPadding),
              Divider(color: Colors.grey.shade300),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 4),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade200,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Text(
              //     context.appLoc.currency,
              //     style: textTheme.titleMedium,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: smallPadding, horizontal: largePadding),
                child: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
                  builder: (context, state) {
                    if (state.status == Status.loaded) {
                      for (var devise in state.devise) {
                        if (devise.change == "Ar/USD") {
                          a = devise.value;
                        } else if (devise.change == "Ar/EUR") {
                          b = devise.value;
                        } else if (devise.change == "CN/USD") {
                          c = devise.value;
                        } else if (devise.change == "INR/USD") {
                          d = devise.value;
                        } else if (devise.change == "W/USD") {
                          e = devise.value;
                        }
                      }

                      return Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ar / \$",
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                              Text(_formatCalculation(a, "MG"),
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ar / €",
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                              Text(_formatCalculation(b, "MG"),
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("CN ¥ / \$",
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                              Text(_formatCalculation(c, "CN"),
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("INR / \$",
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                              Text(_formatCalculation(d, "INR"),
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₩ / \$",
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                              Text(_formatCalculation(e, "WON"),
                                  style: textTheme.bodyLarge!
                                      .copyWith(color: Colors.grey.shade600)),
                            ],
                          )
                        ],
                      );
                    }
                    return Center(child: AppLoadingWidget());
                  },
                ),
              ),
              Divider(color: Colors.grey.shade300),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  context.appLoc.conversion,
                  style: textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Wrap(
                        spacing: 10.0,
                        children: List<Widget>.generate(operations.length,
                            (int index) {
                          return ChoiceChip(
                            label: Text(operations[index]),
                            showCheckmark: false,
                            selected: _value == index,
                            shape: _value == index
                                ? RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: secondaryColor),
                                    borderRadius:
                                        BorderRadius.circular(mediumPadding),
                                  )
                                : RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Colors.grey.shade300),
                                    borderRadius:
                                        BorderRadius.circular(mediumPadding),
                                  ),
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : _value;
                                _calculationController.clear();
                                _calculation(_value, 0.0);
                              });
                            },
                            color: WidgetStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return secondaryColor;
                                }
                                return Colors.white;
                              },
                            ),
                            labelPadding: EdgeInsets.all(0),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: largePadding),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          SingleDecimalInputFormatter(),
                          ThousandsFormatter(
                              formatter: NumberFormat("#,##0.####"),
                              allowFraction: true),
                        ],
                        controller: _calculationController,
                        decoration: InputDecoration(
                          hintText: "000",
                          // hintText: operations[_value!],
                          hintStyle: textTheme.bodyLarge!
                              .copyWith(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onChanged: (value) {
                          // Remove commas before parsing
                          final cleanValue = value.replaceAll(',', '');
                          if (cleanValue.isNotEmpty && cleanValue != '.') {
                            try {
                              final doubleValue = double.parse(cleanValue);
                              setState(() {
                                _calculation(_value,
                                    value.isNotEmpty ? doubleValue : 0.0);
                              });
                            } catch (e) {
                              // Handle parse error
                              print("ERROR");
                            }
                          }
                        },
                        // onChanged: (value) {
                        //   setState(() {
                        //     // print("VALUE: $value");
                        //     _calculation(
                        //         _value,
                        //         value.isNotEmpty
                        //             ? double.parse(value.replaceAll(',', ''))
                        //             : 0.0);
                        //   });
                        // },
                      ),
                    ),
                    const SizedBox(height: largePadding),
                    Column(
                      spacing: largePadding,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CountryFlag.fromLanguageCode(
                                    "mg",
                                    theme: ImageTheme(
                                      height: 32,
                                      width: 32,
                                      shape: Circle(),
                                    ),
                                  ),
                                ),
                                Text("MG (Ar)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_ariary, "MG"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CountryFlag.fromLanguageCode(
                                    "en-us",
                                    theme: ImageTheme(
                                      height: 32,
                                      width: 32,
                                      shape: Circle(),
                                    ),
                                  ),
                                ),
                                Text("USD (\$)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_dollars, "USD"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Flag.fromCode(
                                    FlagsCode.EU,
                                    height: 32,
                                    width: 32,
                                    fit: BoxFit.cover,
                                    borderRadius: 16,
                                  ),
                                ),
                                Text("EURO (€)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_euros, "EURO"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CountryFlag.fromLanguageCode(
                                    "zh",
                                    theme: ImageTheme(
                                      height: 32,
                                      width: 32,
                                      shape: Circle(),
                                    ),
                                  ),
                                ),
                                Text("CN ¥(¥)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_yuans, "USD"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CountryFlag.fromLanguageCode(
                                    "hi",
                                    theme: ImageTheme(
                                      height: 32,
                                      width: 32,
                                      shape: Circle(),
                                    ),
                                  ),
                                ),
                                Text("INR (₹)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_rupees, "USD"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 5.0,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CountryFlag.fromLanguageCode(
                                    "ko",
                                    theme: ImageTheme(
                                      height: 32,
                                      width: 32,
                                      shape: Circle(),
                                    ),
                                  ),
                                ),
                                Text("KRW (₩)")
                              ],
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                _formatCalculation(_wons, "WON"),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              // const SizedBox(height: largePadding),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  context.appLoc.source,
                  style: textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(largePadding),
                child: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
                  builder: (context, state) {
                    if (state.status == Status.loading) {
                      return Center(
                        child: AppLoadingWidget(),
                      );
                    }
                    return Text(
                      state.source,
                      style: textTheme.bodyMedium,
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey.shade300),
              // const SizedBox(height: largePadding),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  context.appLoc.note,
                  style: textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(largePadding),
                child: Text(
                  context.appLoc.note_exchange_description,
                  style: textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      title: Text(
        context.appLoc.exchange_rate,
        style: TextStyle(
          fontFamily: "Pretendard",
          color: Colors.black,
        ),
      ),
    );
  }

  void _calculation(int? value, double f) {
    switch (value) {
      case 0:
        _ariary = f;
        _dollars = f / a;
        _euros = f / b;
        _yuans = f * (c / a);
        _rupees = f * (d / a);
        _wons = f * (e / a);
        break;
      case 1:
        _ariary = f * a;
        _dollars = f;
        _euros = f * (a / b);
        _yuans = f * c;
        _rupees = f * d;
        _wons = f * e;
        break;
      case 2:
        _ariary = f * b;
        _dollars = f * (b / a);
        _euros = f;
        _yuans = f * c * (b / a);
        _rupees = f * d * (b / a);
        _wons = f * e * (b / a);
        break;
      case 3:
        _ariary = f * (a / c);
        _dollars = f / c;
        _euros = f / c * (a / b);
        _yuans = f;
        _rupees = f * (d / c);
        _wons = f * (e / c);
        break;
      case 4:
        _ariary = f * (a / d);
        _dollars = f / d;
        _euros = f / d * (a / b);
        _yuans = f * (c / d);
        _rupees = f;
        _wons = f * (e / d);
        break;
      default:
        _ariary = f * (a / e);
        _dollars = f / e;
        _euros = f / e * (a / b);
        _yuans = f * (c / e);
        _rupees = f * (d / e);
        _wons = f;
        break;
    }
    // case 0:
    //     _ariary = e;
    //     _dollars = e / a;
    //     _euros = e / b;
    //     _yuans = e * (c / a);
    //     _rupees = e;
    //     _wons = e * (d / a);
    //     break;
    //   case 1:
    //     _ariary = e * a;
    //     _dollars = e;
    //     _euros = e * (a / b);
    //     _yuans = e * c;
    //     _rupees = e;
    //     _wons = e * d;
    //     break;
    //   case 2:
    //     _ariary = e * b;
    //     _dollars = e * (b / a);
    //     _euros = e;
    //     _yuans = e * c * (b / a);
    //     _rupees = e;
    //     _wons = e * d * (b / a);
    //     break;
    //   case 3:
    //     _ariary = e * (a / c);
    //     _dollars = e / c;
    //     _euros = e / c * (a / b);
    //     _yuans = e;
    //     _rupees = e;
    //     _wons = e * (d / c);
    //     break;
    //   case 4:
    //     _ariary = e * (a / c);
    //     _dollars = e / d;
    //     _euros = e / d * (a / b);
    //     _yuans = e * (c / d);
    //     _rupees = e;
    //     _wons = e * (e / d);
    //     break;
    //   default:
    //     _ariary = e * (a / d);
    //     _dollars = e / d;
    //     _euros = e / d * (a / b);
    //     _yuans = e * (c / d);
    //     _rupees = e;
    //     _wons = e;
    //     break;
  }

  String _formatCalculation(double value, String currency) {
    NumberFormat formatter = NumberFormat();
    // NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    switch (currency) {
      case "MG" || "USD" || "EURO" || "WON":
        formatter = NumberFormat("#,##0.00");
        break;
      default:
        formatter = NumberFormat("#,##0.0000");
        break;
    }
    return formatter.format(value);
  }
}
