Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <agnel.joel@gmail.com>) id 1f18JP-0000wZ-M4
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 28 Mar 2018 10:28:11 +0000
Received: from mail-lf0-f48.google.com ([209.85.215.48])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f18JN-00DMQ5-TW for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 28 Mar 2018 10:28:11 +0000
Received: by mail-lf0-f48.google.com with SMTP id p142-v6so2724132lfd.6
 for <user-mode-linux-devel@lists.sourceforge.net>;
 Wed, 28 Mar 2018 03:28:09 -0700 (PDT)
MIME-Version: 1.0
From: Joel Fernandes <agnel.joel@gmail.com>
Date: Wed, 28 Mar 2018 03:28:02 -0700
Message-ID: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
Subject: [uml-devel] UML hangs with hrtimer test module
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>

SGksCgpJIHdyb3RlIGEga2VybmVsIG1vZHVsZSB0byBwbGF5IHdpdGggaHJ0aW1lciBzdWJzeXN0
ZW0gYW5kIGl0IGhhbmdzCndpdGggVU1MLCBBbnkgaWRlYXMgb24gd2h5IGl0IG1heSBiZSBoYW5n
aW5nPyBJdCBkb2Vzbid0IGhhbmcgb24gYW55Cm9mIG15IG90aGVyIG1hY2hpbmVzLiBIb3BlZnVs
bHkgSSdtIG5vdCBkb2luZyBzb21ldGhpbmcgc3R1cGlkLCBidXQgSQpkb24ndCB0aGluayBJIGFt
Li4KCkl0IGFwcGVhcnMgdGhlIHRpbWVyIGhhbmRsZXIgZG9lcyBmaXJlLiBIb3dldmVyLCB0aGUg
VU1MIHByb2Nlc3MgaXMKY29udGlub3VzbHkgZG9pbmcgYSBraWxsKFNJR0FMUk0pIHRvIHRoZSBo
b3N0LCBhbmQgdGhlIHNoZWxsIGhhbmdzLgpIZXJlJ3MgdGhlIGNvbnRpbm91cyBzdHJhY2Ugb3V0
cHV0IG9mIFVNTCdzIHByb2Nlc3MgYXQgdGhlIHRpbWUgb2YgdGhlCmhhbmc6IGh0dHBzOi8vaGFz
dGViaW4uY29tL2lrZWhhZGFwb24uc3FsCgpUbyBidWlsZCBVTUwsIEkgZG86Cm1ha2UgQVJDSD11
bSB4ODZfNjRfZGVmY29uZmlnCgpVTUwga2VybmVsIHZlcnNpb24gaXMgdjQuMTYtcmM0CgpIZXJl
J3MgdGhlIG1vZHVsZSBJJ20gbG9hZGluZzoKCu+/vHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFy
dCBiaWd0aW1lcl9oYW5kbGUoc3RydWN0IGhydGltZXIgKnRpbWVyKQp7CiAgICAgICAgcHJpbnRr
KEtFUk5fRVJSICJ0aW1lciBmaXJlZCAyXG4iKTsKICAgICAgICBzcGluX2xvY2soJmlsLT5iaWds
b2NrKTsKICAgICAgICBzcGluX3VubG9jaygmaWwtPmJpZ2xvY2spOwoKICAgICAgICByZWxlYXNl
X25vdyA9IDE7CgogICAgICAgIHJldHVybiBIUlRJTUVSX05PUkVTVEFSVDsKfQoKdm9pZCBpbml0
X2JpZ3N0cihzdHJ1Y3QgYmlnc3RyICpiKQp7CiAgICAgICAgc3Bpbl9sb2NrX2luaXQoJmItPmJp
Z2xvY2spOwp9CgpzdGF0aWMgaW50IF9faW5pdCB0ZXN0X21vZHVsZV9pbml0KHZvaWQpCnsKICAg
ICAgICBzdHJ1Y3QgYmlnc3RyIGIxLCBiMjsKICAgICAgICBzdHJ1Y3QgaHJ0aW1lciAqdGltZXI7
CgogICAgICAgIHJlbGVhc2Vfbm93ID0gMDsKCiAgICAgICAgaW5pdF9iaWdzdHIoJmIxKTsKICAg
ICAgICBpbml0X2JpZ3N0cigmYjIpOwoKICAgICAgICB0aW1lciA9ICZiaWd0aW1lcjsKICAgICAg
ICB0aW1lci0+ZGVidWcgPSAxOwoKICAgICAgICBocnRpbWVyX2luaXQodGltZXIsIENMT0NLX01P
Tk9UT05JQywgSFJUSU1FUl9NT0RFX1JFTCk7CiAgICAgICAgdGltZXItPmZ1bmN0aW9uID0gYmln
dGltZXJfaGFuZGxlOwoKICAgICAgICBpbCA9ICZiMjsKICAgICAgICBzcGluX2xvY2soJmIxLmJp
Z2xvY2spOwoKICAgICAgICBwcmludGsoS0VSTl9FUlIgIlN0YXJ0aW5nIHRpbWVyXG4iKTsKICAg
ICAgICBocnRpbWVyX3N0YXJ0KHRpbWVyLCBuc190b19rdGltZSg1MDAwMFVMTCksCiAgICAgICAg
ICAgICAgICAgICAgICBIUlRJTUVSX01PREVfUkVMX1BJTk5FRCk7CgogICAgICAgIHdoaWxlKHJl
bGVhc2Vfbm93ID09IDApOwoKICAgICAgICBzcGluX3VubG9jaygmYjEuYmlnbG9jayk7CiAgICAg
ICAgcmV0dXJuIC0xOwp9CgoKVGhhbmtzIGZvciBhbnkgZGVidWcgdGhvdWdodHMhCkknbGwgYWxz
byB0cnkgdG8gaG9vayB1cCBnZGIgdG9tb3Jyb3cgYW5kIHNlZSBpZiBJIGZpbmQgc29tZXRoaW5n
Li4KClJlZ2FyZHMsCgotIEpvZWwKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBvdXQgdGhl
IHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QKZW5nYWdp
bmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hkb3QKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxp
bnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3Vz
ZXItbW9kZS1saW51eC1kZXZlbAo=

