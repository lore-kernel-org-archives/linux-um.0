Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CF6o6-00045s-Vt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 01:05:54 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CF6o5-0006zy-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 01:05:54 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C4AB7B.3EB0B423"
Subject: RE: [uml-devel] Re: 2.4.27 + 2.4.26-3um - Kernel panic: handle_trap -
	failed to wait at end of syscall, errno = 4, status = 4479
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C4F@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 6 Oct 2004 10:05:29 +0200
To: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4AB7B.3EB0B423
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Christopher S. Aker said:
>Another tidbit of information...
>
>A user of mind has two UMLs on two different hosts.  Both the UMLs are
running Debian unstable.
>This kernel on the 2.6.4 host doesn't work, while the other on a
2.6.7+sysemu box does.
>
>-Chris

Yes. That's exactly what happened with my uml 2.6.8.1 with the
sysemu-patch. And I can see the same problem in the 2.4.26 sysemu-patch,
that is used in your UML kernel (As the console prinout tells).
If sysemu isn't used, but the patch is applied, the correct sequence of
first nullifying a systemcall on the host and than calling
handle_syscall() in handle_trap() is inverted, what causes the problem.
In 2.6.9 sysemu is implemented correctly.
The attached patch (sorry, can't inline it, due to my silly mailer ...)
will correct the sequence and should let your kernel work with or
without sysemu support.
Please note, this is a patch against 2.6.8.1, you might need to adapt it
a bit.

Bodo

------_=_NextPart_001_01C4AB7B.3EB0B423
Content-Type: application/octet-stream;
	name="patch-sysemu-panic"
Content-Transfer-Encoding: base64
Content-Description: patch-sysemu-panic
Content-Disposition: attachment;
	filename="patch-sysemu-panic"

LS0tIHVtbC5vcmlnL2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jCTIwMDQtMDktMTcgMTk6
MjA6MTUuMDAwMDAwMDAwICswMjAwDQorKysgdW1sL2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vz
cy5jCTIwMDQtMDktMjEgMTQ6MzI6MjIuMTI5MzI3NjMxICswMjAwDQpAQCAtNjgsMjUgKzY4LDI1
IEBADQogCQlyZXR1cm47DQogCX0NCiANCi0JaGFuZGxlX3N5c2NhbGwocmVncyk7DQotCWlmKHVz
ZV9zeXNlbXUpDQotCQlyZXR1cm47DQorCWlmKCF1c2Vfc3lzZW11KSB7DQorCQllcnIgPSBwdHJh
Y2UoUFRSQUNFX1BPS0VVU0VSLCBwaWQsIFBUX1NZU0NBTExfTlJfT0ZGU0VULCBfX05SX2dldHBp
ZCk7DQorCQlpZihlcnIgPCAwKQ0KKwkJCXBhbmljKCJoYW5kbGVfdHJhcCAtIG51bGxpZnlpbmcg
c3lzY2FsbCBmYWlsZWQsIGVycm5vID0gJWRcbiIsDQorCQkJICAgICAgZXJybm8pOw0KIA0KLQll
cnIgPSBwdHJhY2UoUFRSQUNFX1BPS0VVU0VSLCBwaWQsIFBUX1NZU0NBTExfTlJfT0ZGU0VULCBf
X05SX2dldHBpZCk7DQotCWlmKGVyciA8IDApDQotCQlwYW5pYygiaGFuZGxlX3RyYXAgLSBudWxs
aWZ5aW5nIHN5c2NhbGwgZmFpbGVkLCBlcnJubyA9ICVkXG4iLA0KLQkJICAgICAgZXJybm8pOw0K
KwkJZXJyID0gcHRyYWNlKFBUUkFDRV9TWVNDQUxMLCBwaWQsIDAsIDApOw0KKwkJaWYoZXJyIDwg
MCkNCisJCQlwYW5pYygiaGFuZGxlX3RyYXAgLSBjb250aW51aW5nIHRvIGVuZCBvZiBzeXNjYWxs
IGZhaWxlZCwgIg0KKwkJCSAgICAgICJlcnJubyA9ICVkXG4iLCBlcnJubyk7DQogDQotCWVyciA9
IHB0cmFjZShQVFJBQ0VfU1lTQ0FMTCwgcGlkLCAwLCAwKTsNCi0JaWYoZXJyIDwgMCkNCi0JCXBh
bmljKCJoYW5kbGVfdHJhcCAtIGNvbnRpbnVpbmcgdG8gZW5kIG9mIHN5c2NhbGwgZmFpbGVkLCAi
DQotCQkgICAgICAiZXJybm8gPSAlZFxuIiwgZXJybm8pOw0KLQ0KLQlDQVRDSF9FSU5UUihlcnIg
PSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgV1VOVFJBQ0VEKSk7DQotCWlmKChlcnIgPCAwKSB8fCAh
V0lGU1RPUFBFRChzdGF0dXMpIHx8IA0KLQkgICAoV1NUT1BTSUcoc3RhdHVzKSAhPSBTSUdUUkFQ
KSkNCi0JCXBhbmljKCJoYW5kbGVfdHJhcCAtIGZhaWxlZCB0byB3YWl0IGF0IGVuZCBvZiBzeXNj
YWxsLCAiDQotCQkgICAgICAiZXJybm8gPSAlZCwgc3RhdHVzID0gJWRcbiIsIGVycm5vLCBzdGF0
dXMpOw0KKwkJQ0FUQ0hfRUlOVFIoZXJyID0gd2FpdHBpZChwaWQsICZzdGF0dXMsIFdVTlRSQUNF
RCkpOw0KKwkJaWYoKGVyciA8IDApIHx8ICFXSUZTVE9QUEVEKHN0YXR1cykgfHwgDQorCQkgICAo
V1NUT1BTSUcoc3RhdHVzKSAhPSBTSUdUUkFQKSkNCisJCQlwYW5pYygiaGFuZGxlX3RyYXAgLSBm
YWlsZWQgdG8gd2FpdCBhdCBlbmQgb2Ygc3lzY2FsbCwgIg0KKwkJCSAgICAgICJlcnIgPSAlZCwg
ZXJybm8gPSAlZCwgc3RhdHVzID0gJXhcbiIsIGVyciwgZXJybm8sIHN0YXR1cyk7DQorCX0NCisN
CisJaGFuZGxlX3N5c2NhbGwocmVncyk7DQogfQ0KIA0KIHN0YXRpYyBpbnQgdXNlcnNwYWNlX3Ry
YW1wKHZvaWQgKmFyZykNCg==

------_=_NextPart_001_01C4AB7B.3EB0B423--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
