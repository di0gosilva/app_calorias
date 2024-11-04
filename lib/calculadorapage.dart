import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController peso = TextEditingController();
  FocusNode focusNode = FocusNode();
  int _selectedIndex = 0;
  String? _selectedGender;
  int totalCalorias = 0;
  String result = "";

  void calcularTotalCalorias() {
    setState(() {
      double? pesoNum = double.tryParse(peso.text);

      if (pesoNum != null) {
        if (_selectedGender == 'Masculino') {
          totalCalorias = (pesoNum * 20).toInt();
        } else if (_selectedGender == 'Feminino') {
          totalCalorias = (pesoNum * 15).toInt();
        }
        result =
            "Seu consumo diário ideal de calorias deve ser $totalCalorias calorias.";
      } else {
        result = "Por favor, insira um peso válido!";
      }

      peso.text = "";
      FocusScope.of(context).unfocus();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void removerFocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 0),
              child: IconButton(
                icon: Icon(
                  Icons.fastfood_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: null,
              ),
            ),
            const Text(
              "CALCULADORA",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          children: [
            const ListTile(
              title: Text(
                'CALORIAS',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              onTap: null,
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 65, 0, 0),
              title: const Text(
                'Contador de Calorias',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pushNamed(context, '/mainPage');
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              title: const Text(
                'Calculadora de Calorias',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 65, 0, 0),
              title: const Text(
                'Sair',
                style: TextStyle(
                    color: Color.fromARGB(112, 255, 255, 255), fontSize: 20),
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: removerFocus,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 33, 33, 33), // Cor da borda
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Qual o seu peso atual?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: peso,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Peso',
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 33, 33, 33),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Sexo:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio<String>(
                                  value: 'Masculino',
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Masculino',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Radio<String>(
                                  value: 'Feminino',
                                  groupValue: _selectedGender,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Feminino',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: calcularTotalCalorias,
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 33, 33, 33),
                            fixedSize: const Size(0, 55),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Calcular",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
