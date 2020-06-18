import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pixez/bloc/bloc.dart';
import 'package:pixez/generated/l10n.dart';
import 'package:pixez/main.dart';
import 'package:pixez/models/ban_illust_id.dart';
import 'package:pixez/models/ban_tag.dart';
import 'package:pixez/models/ban_user_id.dart';

class ShieldPage extends StatefulWidget {
  @override
  _ShieldPageState createState() => _ShieldPageState();
}

class _ShieldPageState extends State<ShieldPage> {
  @override
  void initState() {
    muteStore.fetchBanUserIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MuteBloc, MuteState>(builder: (context, snapshot) {
      return Observer(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(I18n.of(context).Shielding_settings),
            ),
            body: snapshot is DataMuteState
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(I18n.of(context).Tag),
                          Container(
                            child: Wrap(
                              spacing: 2.0,
                              runSpacing: 2.0,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                ...snapshot.banTags
                                    .map((f) => ActionChip(
                                          onPressed: () =>
                                              deleteTag(context, f),
                                          label: Text(f.name),
                                        ))
                                    .toList()
                              ],
                            ),
                          ),
                          Divider(),
                          Text(I18n.of(context).Painter),
                          Container(
                            child: Wrap(
                              spacing: 2.0,
                              runSpacing: 2.0,
                              direction: Axis.horizontal,
                              children: muteStore.banUserIds
                                  .map((f) => ActionChip(
                                        onPressed: () =>
                                            _deleteUserIdTag(context, f),
                                        label: Text(f.name),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Divider(),
                          Text(I18n.of(context).Illust),
                          Container(
                            child: Wrap(
                              spacing: 2.0,
                              runSpacing: 2.0,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                ...snapshot.banIllustIds
                                    .map((f) => ActionChip(
                                          onPressed: () =>
                                              _deleteIllust(context, f),
                                          label: Text(f.name),
                                        ))
                                    .toList()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          );
        },
      );
    });
  }

  Future deleteTag(BuildContext context, BanTagPersist f) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(I18n
              .of(context)
              .Delete),
          content: Text('Delete this tag?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, "OK");
              },
              child: Text(I18n
                  .of(context)
                  .OK),
            ),
            FlatButton(
              child: Text(I18n
                  .of(context)
                  .Cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
    switch (result) {
      case "OK":
        {
          BlocProvider.of<MuteBloc>(context).add(DeleteTagEvent(f.id));
        }
        break;
    }
  }

  Future _deleteIllust(BuildContext context, BanIllustIdPersist f) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(I18n
              .of(context)
              .Delete),
          content: Text('Delete this tag?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, "OK");
              },
              child: Text(I18n
                  .of(context)
                  .OK),
            ),
            FlatButton(
              child: Text(I18n
                  .of(context)
                  .Cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
    switch (result) {
      case "OK":
        {
          BlocProvider.of<MuteBloc>(context).add(DeleteIllustEvent(f.id));
        }
        break;
    }
  }

  Future _deleteUserIdTag(BuildContext context, BanUserIdPersist f) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(I18n
              .of(context)
              .Delete),
          content: Text('Delete this tag?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, "OK");
              },
              child: Text(I18n
                  .of(context)
                  .OK),
            ),
            FlatButton(
              child: Text(I18n
                  .of(context)
                  .Cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
    switch (result) {
      case "OK":
        {
          muteStore.deleteBanUserId(f.id);
        }
        break;
    }
  }
}
