Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJfdu-0004UK-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 13:01:42 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJfdt-0008Vm-ES
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 11 Nov 2003 13:01:41 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id hABL1ZP10900
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 21:01:35 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id hABL1Yk6010321
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 21:01:34 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id hABL1Xe05820
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 21:01:33 GMT
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Child exit when booting uml 2.4.20 on 2.6.0-test4
 host
Message-ID: <Pine.GSO.4.58.0311112056030.5253@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1068584493=:5253"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 11 Nov 2003 21:01:33 +0000 (GMT)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1068584493=:5253
Content-Type: TEXT/PLAIN; charset=US-ASCII

jdike wrote:

>> If you have little  time, I can post this
>> together with a patch to the spec file which is again  out of
>> date(some files are not listed).
>
>Send me a patch to the spec file, please.

It is a fairly trival fix, eg. see the attached patch.

	Michael Young
---559023410-1804928587-1068584493=:5253
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="umlutilspec.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="umlutilspec.patch"

ZGlmZiAtTmF1ciB0b29scy91bWxfdXRpbC5zcGVjLm9yaWcgdG9vbHMvdW1s
X3V0aWwuc3BlYw0KLS0tIHRvb2xzL3VtbF91dGlsLnNwZWMub3JpZwkyMDAz
LTA5LTAzIDIwOjM1OjQ1LjAwMDAwMDAwMCArMDEwMA0KKysrIHRvb2xzL3Vt
bF91dGlsLnNwZWMJMjAwMy0xMS0xMSAyMDozNjoxNS4wMDAwMDAwMDAgKzAw
MDANCkBAIC0zNCw5ICszNCwxMSBAQA0KICMlYXR0cig3NTUscm9vdCxyb290
KQkJCSV7X2JpbmRpcn0vbWtyb290ZnMNCiAlYXR0cig3NTUscm9vdCxyb290
KQkJCSV7X2JpbmRpcn0vdHVuY3RsDQogJWF0dHIoNzU1LHJvb3Qscm9vdCkJ
CQkle19iaW5kaXJ9L3VtbF9tY29uc29sZQ0KKyVhdHRyKDc1NSxyb290LHJv
b3QpCQkJJXtfYmluZGlyfS91bWxfbWtjb3cNCiAlYXR0cig3NTUscm9vdCxy
b290KQkJCSV7X2JpbmRpcn0vdW1sX21vbw0KICVhdHRyKDQ3NTUscm9vdCxy
b290KQkJCSV7X2JpbmRpcn0vdW1sX25ldA0KICVhdHRyKDc1NSxyb290LHJv
b3QpCQkJJXtfYmluZGlyfS91bWxfc3dpdGNoDQorJWF0dHIoNzU1LHJvb3Qs
cm9vdCkJCQkle19iaW5kaXJ9L3VtbF93YXRjaGRvZw0KICVhdHRyKDc1NSxy
b290LHJvb3QpCQklZGlyCSV7X2xpYmRpcn0vdW1sDQogIyVhdHRyKDc1NSxy
b290LHJvb3QpCQkJJXtfbGliZGlyfS91bWwvZnVuY3Rpb25zDQogJWF0dHIo
NzU1LHJvb3Qscm9vdCkJCQkle19saWJkaXJ9L3VtbC9wb3J0LWhlbHBlcg0K
ZGlmZiAtTmF1ciB0b29scy91bWxfdXRpbC5zcGVjLmluLm9yaWcgdG9vbHMv
dW1sX3V0aWwuc3BlYy5pbg0KLS0tIHRvb2xzL3VtbF91dGlsLnNwZWMuaW4u
b3JpZwkyMDAzLTA2LTE3IDIwOjIxOjQ1LjAwMDAwMDAwMCArMDEwMA0KKysr
IHRvb2xzL3VtbF91dGlsLnNwZWMuaW4JMjAwMy0xMS0xMSAyMDozNzoyNC4w
MDAwMDAwMDAgKzAwMDANCkBAIC0zNCw5ICszNCwxMSBAQA0KICMlYXR0cig3
NTUscm9vdCxyb290KQkJCSV7X2JpbmRpcn0vbWtyb290ZnMNCiAlYXR0cig3
NTUscm9vdCxyb290KQkJCSV7X2JpbmRpcn0vdHVuY3RsDQogJWF0dHIoNzU1
LHJvb3Qscm9vdCkJCQkle19iaW5kaXJ9L3VtbF9tY29uc29sZQ0KKyVhdHRy
KDc1NSxyb290LHJvb3QpCQkJJXtfYmluZGlyfS91bWxfbWtjb3cNCiAlYXR0
cig3NTUscm9vdCxyb290KQkJCSV7X2JpbmRpcn0vdW1sX21vbw0KICVhdHRy
KDQ3NTUscm9vdCxyb290KQkJCSV7X2JpbmRpcn0vdW1sX25ldA0KICVhdHRy
KDc1NSxyb290LHJvb3QpCQkJJXtfYmluZGlyfS91bWxfc3dpdGNoDQorJWF0
dHIoNzU1LHJvb3Qscm9vdCkJCQkle19iaW5kaXJ9L3VtbF93YXRjaGRvZw0K
ICVhdHRyKDc1NSxyb290LHJvb3QpCQklZGlyCSV7X2xpYmRpcn0vdW1sDQog
IyVhdHRyKDc1NSxyb290LHJvb3QpCQkJJXtfbGliZGlyfS91bWwvZnVuY3Rp
b25zDQogJWF0dHIoNzU1LHJvb3Qscm9vdCkJCQkle19saWJkaXJ9L3VtbC9w
b3J0LWhlbHBlcg0K

---559023410-1804928587-1068584493=:5253--


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
