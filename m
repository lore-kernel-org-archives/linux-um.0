Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0TAU-0001Wj-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 18:05:34 -0700
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G0TAS-0004Qq-KQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 18:05:34 -0700
Received: from qmiao ([218.104.33.229])
	(envelope-sender <qmiao@centecnetworks.com>)
	by 192.168.25.7 with ESMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Jul 2006 09:05:17 +0800
Message-ID: <019a01c6a54f$405ffdf0$d4190a0a@centecnetworks.com>
From: "Miao Qingjun" <qmiao@centecnetworks.com>
Date: Wed, 12 Jul 2006 09:05:22 +0800
MIME-Version: 1.0
Subject: [uml-devel] uml and gdb debugging questions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1735714619=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1735714619==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0197_01C6A592.4E702B20"

This is a multi-part message in MIME format.

------=_NextPart_000_0197_01C6A592.4E702B20
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNCkkgaGF2ZSBzZXZlcmFsIHByb2JsZW1zIGFib3V0IHVtbC0yLjYuMTcgYW5kIGdkYiBk
ZWJ1Z2dpbmcuDQoNCkkgc3RhcnQgImdkYiB1bWwiLCAiYiBzeXNfaW5pdF9tb2R1bGUiLCB0aGVu
ICJydW4iLA0KYnV0IGdkYiBpcyBub3QgYnJlYWsgYXQgc3lzX2luaXRfbW9kdWxlKCkgd2hlbiBJ
IGluc21vZCBMS00/DQpXaHk/IEhvdyBjYW4gSSBkbyBpdD8NCg0KDQpXaGVuIEkgdHlwZSBjb250
cm9sLWMgaW4gZ2RiLCB0aGUgdmlydHVhbCBjb25zb2xlIHh0ZXJtIGlzIGFsc28gY2xvc2VkLA0K
SSBqdXN0IHdhbnQgdG8gZW50ZXIgZ2RiIGNvbW1hbmQgbGluZSB0byBzaW5nbGUgc3RlcCBrZXJu
ZWwgY29kZSwgaG93IGNhbiBJIGRvIGl0Pw0KDQoNCnRoYW5rcyE=

------=_NextPart_000_0197_01C6A592.4E702B20
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI2MjciIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj5IaSw8L0ZPTlQ+PC9ESVY+
DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIHNpemU9
Mj5JIGhhdmUgc2V2ZXJhbCBwcm9ibGVtcyBhYm91dCB1bWwtMi42LjE3IGFuZCBnZGIgDQpkZWJ1
Z2dpbmcuPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElW
Pg0KPERJVj48Rk9OVCBzaXplPTI+SSBzdGFydCAiZ2RiIHVtbCIsICJiIHN5c19pbml0X21vZHVs
ZSIsIHRoZW4gDQoicnVuIiw8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5idXQgZ2Ri
IGlzIG5vdCBicmVhayBhdCBzeXNfaW5pdF9tb2R1bGUoKSB3aGVuIEkgaW5zbW9kIA0KTEtNPzwv
Rk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPldoeT8gSG93IGNhbiBJIGRvIGl0PzwvRk9O
VD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZP
TlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPldoZW4gSSB0
eXBlIGNvbnRyb2wtYyBpbiBnZGIsIHRoZSB2aXJ0dWFsIGNvbnNvbGUgeHRlcm0gaXMgDQphbHNv
IGNsb3NlZCw8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5JIGp1c3Qgd2FudCB0byBl
bnRlciBnZGIgY29tbWFuZCBsaW5lIHRvIHNpbmdsZSBzdGVwIGtlcm5lbCANCmNvZGUsIGhvdyBj
YW4gSSBkbyBpdD88L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7
PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05U
IHNpemU9Mj50aGFua3MhPC9GT05UPjwvRElWPjwvQk9EWT48L0hUTUw+DQo=

------=_NextPart_000_0197_01C6A592.4E702B20--



--===============1735714619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1735714619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1735714619==--

