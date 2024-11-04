import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController alimentoCafe = TextEditingController();
  TextEditingController qtdCafe = TextEditingController();
  TextEditingController caloriasCafe = TextEditingController();

  TextEditingController alimentoAlmoco = TextEditingController();
  TextEditingController qtdAlmoco = TextEditingController();
  TextEditingController caloriasAlmoco = TextEditingController();

  TextEditingController alimentoLanche = TextEditingController();
  TextEditingController qtdLanche = TextEditingController();
  TextEditingController caloriasLanche = TextEditingController();

  TextEditingController alimentoJantar = TextEditingController();
  TextEditingController qtdJantar = TextEditingController();
  TextEditingController caloriasJantar = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int totalCalorias = 0;
  int _selectedIndex = 0;
  List<Map<String, String>> itens = [];
  List<Map<String, String>> itensCafe = [];
  List<Map<String, String>> itensAlmoco = [];
  List<Map<String, String>> itensLanche = [];
  List<Map<String, String>> itensJantar = [];

  FocusNode focusNode = FocusNode();

  void adicionarItem(TextEditingController alimento, TextEditingController qtd,
      TextEditingController calorias, String refeicao) {
    int valorCalorias = int.tryParse(calorias.text) ?? 0;
    setState(() {
      if (refeicao == "cafe") {
        itensCafe.add({
          'alimento': alimento.text,
          'qtd': qtd.text,
          'calorias': calorias.text,
        });
      } else if (refeicao == "almoco") {
        itensAlmoco.add({
          'alimento': alimento.text,
          'qtd': qtd.text,
          'calorias': calorias.text,
        });
      } else if (refeicao == "lanche") {
        itensLanche.add({
          'alimento': alimento.text,
          'qtd': qtd.text,
          'calorias': calorias.text,
        });
      } else if (refeicao == "jantar") {
        itensJantar.add({
          'alimento': alimento.text,
          'qtd': qtd.text,
          'calorias': calorias.text,
        });
      }
      totalCalorias += valorCalorias;
      alimento.clear();
      qtd.clear();
      calorias.clear();
    });
  }

  void removerItem(int index, String refeicao) {
    int valorCalorias = 0;
    setState(() {
      if (refeicao == "cafe") {
        valorCalorias = int.tryParse(itensCafe[index]['calorias'] ?? '0') ?? 0;
        itensCafe.removeAt(index);
      } else if (refeicao == "almoco") {
        valorCalorias =
            int.tryParse(itensAlmoco[index]['calorias'] ?? '0') ?? 0;
        itensAlmoco.removeAt(index);
      } else if (refeicao == "lanche") {
        valorCalorias =
            int.tryParse(itensLanche[index]['calorias'] ?? '0') ?? 0;
        itensLanche.removeAt(index);
      } else if (refeicao == "jantar") {
        valorCalorias =
            int.tryParse(itensJantar[index]['calorias'] ?? '0') ?? 0;
        itensJantar.removeAt(index);
      }
      totalCalorias -= valorCalorias;
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
              "CONTADOR",
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
                Navigator.pop(context);
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
                Navigator.pushNamed(context, '/calculadora');
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Card - Total de calorias
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 11),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 33, 33),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "$totalCalorias calorias",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Cards de refeição
              _buildRefeicaoCard("Café da Manhã", alimentoCafe, qtdCafe,
                  caloriasCafe, itensCafe, "cafe"),
              _buildRefeicaoCard("Almoço", alimentoAlmoco, qtdAlmoco,
                  caloriasAlmoco, itensAlmoco, "almoco"),
              _buildRefeicaoCard("Lanches", alimentoLanche, qtdLanche,
                  caloriasLanche, itensLanche, "lanche"),
              _buildRefeicaoCard("Jantar", alimentoJantar, qtdJantar,
                  caloriasJantar, itensJantar, "jantar"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefeicaoCard(
      String refeicao,
      TextEditingController alimentoController,
      TextEditingController qtdController,
      TextEditingController caloriasController,
      List<Map<String, String>> itensRefeicao,
      String refeicaoKey) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: const Color.fromARGB(255, 33, 33, 33), // Cor da borda
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    refeicao,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: alimentoController,
                    label: "Alimento",
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: qtdController,
                    label: "Quantidade",
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: caloriasController,
                    label: "Calorias",
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      if (alimentoController.text.isNotEmpty &&
                          qtdController.text.isNotEmpty &&
                          caloriasController.text.isNotEmpty) {
                        adicionarItem(alimentoController, qtdController,
                            caloriasController, refeicaoKey);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                      fixedSize: const Size(0, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Adicionar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itensRefeicao.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  color: const Color.fromARGB(255, 33, 33, 33),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    textColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 6, 0),
                    title: Text(
                      "${itensRefeicao[index]['alimento']} | ${itensRefeicao[index]['qtd']}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle:
                        Text("${itensRefeicao[index]['calorias']} calorias"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.white,
                      onPressed: () {
                        removerItem(index, refeicaoKey);
                      },
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  /*
  const SizedBox(height: 15),
  ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itensRefeicao.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Card(
          color: const Color.fromARGB(255, 33, 33, 33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            textColor: Colors.white,
            contentPadding:
                const EdgeInsets.fromLTRB(20, 0, 6, 0),
            title: Text(
              "${itensRefeicao[index]['alimento']} | ${itensRefeicao[index]['qtd']}",
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
                "${itensRefeicao[index]['calorias']} calorias"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                removerItem(index, refeicaoKey);
              },
            ),
          ),
        ),
      );
    },
  ),*/

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
        filled: true,
        fillColor: const Color.fromARGB(255, 33, 33, 33),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
