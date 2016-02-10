Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1aTVnY-0006iW-RN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aTVnT-0008Ds-6q
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Feb 2016 14:31:16 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Wed, 10 Feb 2016 15:29:42 +0100
Message-Id: <1455114596-3532-7-git-send-email-vegard.nossum@oracle.com>
In-Reply-To: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
References: <1455114596-3532-1-git-send-email-vegard.nossum@oracle.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 07/21] usb: add HAS_IOMEM dependency to
	USB_C67X00_HCD
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, James McMechan <James_McMechan@hotmail.com>, Vegard Nossum <vegard.nossum@oracle.com>

ICBDQyAgICAgIGRyaXZlcnMvdXNiL2M2N3gwMC9jNjd4MDAtZHJ2Lm8KZHJpdmVycy91c2IvYzY3
eDAwL2M2N3gwMC1kcnYuYzogSW4gZnVuY3Rpb24g4oCYYzY3eDAwX2Rydl9wcm9iZeKAmToKZHJp
dmVycy91c2IvYzY3eDAwL2M2N3gwMC1kcnYuYzoxNDg6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlvcmVtYXDigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dCiAgYzY3eDAwLT5ocGkuYmFzZSA9IGlvcmVtYXAocmVzLT5zdGFydCwg
cmVzb3VyY2Vfc2l6ZShyZXMpKTsKICBeCmRyaXZlcnMvdXNiL2M2N3gwMC9jNjd4MDAtZHJ2LmM6
MTQ4OjE5OiB3YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdp
dGhvdXQgYSBjYXN0IFtlbmFibGVkIGJ5IGRlZmF1bHRdCiAgYzY3eDAwLT5ocGkuYmFzZSA9IGlv
cmVtYXAocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKICAgICAgICAgICAgICAgICAg
IF4KZHJpdmVycy91c2IvYzY3eDAwL2M2N3gwMC1kcnYuYzoxODU6MjogZXJyb3I6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGlvdW5tYXDigJkgWy1XZXJyb3I9aW1wbGljaXQt
ZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgaW91bm1hcChjNjd4MDAtPmhwaS5iYXNlKTsKICBeCgpT
aWduZWQtb2ZmLWJ5OiBWZWdhcmQgTm9zc3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+Ci0t
LQogZHJpdmVycy91c2IvaG9zdC9LY29uZmlnIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L0tjb25maWcgYi9kcml2ZXJz
L3VzYi9ob3N0L0tjb25maWcKaW5kZXggYWYyMGQ5My4uZTc4MWZiMSAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvaG9zdC9LY29uZmlnCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZwpAQCAt
NSw2ICs1LDcgQEAgY29tbWVudCAiVVNCIEhvc3QgQ29udHJvbGxlciBEcml2ZXJzIgogCiBjb25m
aWcgVVNCX0M2N1gwMF9IQ0QKIAl0cmlzdGF0ZSAiQ3lwcmVzcyBDNjd4MDAgSENEIHN1cHBvcnQi
CisJZGVwZW5kcyBvbiBIQVNfSU9NRU0KIAloZWxwCiAJICBUaGUgQ3lwcmVzcyBDNjd4MDAgKEVa
LUhvc3QvRVotT1RHKSBjaGlwcyBhcmUgZHVhbC1yb2xlCiAJICBob3N0L3BlcmlwaGVyYWwvT1RH
IFVTQiBjb250cm9sbGVycy4KLS0gCjEuOS4xCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClNpdGUy
NHg3IEFQTSBJbnNpZ2h0OiBHZXQgRGVlcCBWaXNpYmlsaXR5IGludG8gQXBwbGljYXRpb24gUGVy
Zm9ybWFuY2UKQVBNICsgTW9iaWxlIEFQTSArIFJVTTogTW9uaXRvciAzIEFwcCBpbnN0YW5jZXMg
YXQganVzdCAkMzUvTW9udGgKTW9uaXRvciBlbmQtdG8tZW5kIHdlYiB0cmFuc2FjdGlvbnMgYW5k
IHRha2UgY29ycmVjdGl2ZSBhY3Rpb25zIG5vdwpUcm91Ymxlc2hvb3QgZmFzdGVyIGFuZCBpbXBy
b3ZlIGVuZC11c2VyIGV4cGVyaWVuY2UuIFNpZ251cCBOb3chCmh0dHA6Ly9wdWJhZHMuZy5kb3Vi
bGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD0yNzI0ODcxNTEmaXU9LzQxNDAKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVs
IG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1s
aW51eC1kZXZlbAo=

