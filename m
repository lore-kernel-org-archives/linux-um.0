Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G10dS-0001xn-ML for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 05:49:42 -0700
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G10dR-0002ki-3R
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 05:49:42 -0700
Received: from qmiao ([218.104.33.229])
	(envelope-sender <qmiao@centecnetworks.com>)
	by 192.168.25.7 with ESMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Jul 2006 20:49:28 +0800
Message-ID: <023b01c6a67a$c94b6420$d4190a0a@centecnetworks.com>
From: "Miao Qingjun" <qmiao@centecnetworks.com>
Date: Thu, 13 Jul 2006 20:49:31 +0800
MIME-Version: 1.0
Subject: [uml-devel] SIGTRAP and gdb multithreading program under UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0198542791=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0198542791==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0238_01C6A6BD.D7592050"

This is a multi-part message in MIME format.

------=_NextPart_000_0238_01C6A6BD.D7592050
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNClVuZGVyIFVNTCBiYXNoLCBJIGdkYiBhIG11bHRpdGhyZWFkaW5nIHByb2dyYW0sIGFu
ZCBzZXQgYSBicmVha3BvaW50IG9uIHRocmVhZCBlbnRyeSBmdW5jdGlvbiwNCkJ1dCB3aGVuIHJ1
biBpdCwgZ2RiIGlzIG5vdCBzdG9wIGF0IHRoZSBicmVha3BvaW50LCANCmluc3RlYWQsIHByb2dy
YW0gZXhpdCBiZWNhdXNlOg0KDQpQcm9ncmFtIHRlcm1pbmF0ZWQgd2l0aCBzaWduYWwgU0lHVFJB
UCwgVHJhY2UvYnJlYWtwb2ludCB0cmFwLg0KDQpXaHk/DQoNClRoYW5rcy4=

------=_NextPart_000_0238_01C6A6BD.D7592050
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI2MjciIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj5IaSw8L0ZPTlQ+PC9ESVY+
DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIHNpemU9
Mj5VbmRlciBVTUwgYmFzaCwgSSBnZGIgYSBtdWx0aXRocmVhZGluZyBwcm9ncmFtLCBhbmQgc2V0
IGEgDQpicmVha3BvaW50IG9uIHRocmVhZCBlbnRyeSBmdW5jdGlvbiw8L0ZPTlQ+PC9ESVY+DQo8
RElWPjxGT05UIHNpemU9Mj5CdXQgd2hlbiBydW4gaXQsIGdkYiBpcyBub3Qgc3RvcCBhdCB0aGUg
YnJlYWtwb2ludCwgDQo8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5pbnN0ZWFkLCBw
cm9ncmFtIGV4aXQgYmVjYXVzZTo8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj48L0ZP
TlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5Qcm9ncmFtIHRlcm1pbmF0ZWQgd2l0
aCBzaWduYWwgU0lHVFJBUCwgVHJhY2UvYnJlYWtwb2ludCANCnRyYXAuPC9GT05UPjwvRElWPg0K
PERJVj48Rk9OVCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+
V2h5PzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4N
CjxESVY+PEZPTlQgc2l6ZT0yPlRoYW5rcy48L0ZPTlQ+PC9ESVY+PC9CT0RZPjwvSFRNTD4NCg==

------=_NextPart_000_0238_01C6A6BD.D7592050--



--===============0198542791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0198542791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0198542791==--

