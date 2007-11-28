Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxMfu-0001T2-Az for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 05:09:58 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxMfr-0000jg-It
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 05:09:58 -0800
In-reply-to: <20071128125030.GB21791@elte.hu> (message from Ingo Molnar on
	Wed, 28 Nov 2007 13:50:30 +0100)
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
MIME-version: 1.0
Message-Id: <E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 14:09:45 +0100
Subject: Re: [uml-devel] -rt doesn't compile for UML
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: mingo@elte.hu
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

PiAqIE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4gd3JvdGU6Cj4gCj4gPiBXaGVu
IHdyaXRpbmcgYSBiaWcgZmlsZSB0byBhIHViZCBkaXNrLCBldmVyeXRoaW5nIGluIHVtbCBzbG93
cyBkb3duIHRvCj4gPiBhIGNyYXdsLCBldmVuIHRob3VnaCBDUFUgdXNhZ2UgaXMgbWluaW1hbC4K
PiA+IAo+ID4gU28gSSB3YW50ZWQgdG8gdHJ5IHRoZSBsYXRlbmN5IHRyYWNlciBmcm9tIC1ydCwg
YnV0IGl0IGRvZXNuJ3QgY29tcGlsZSAKPiA+IHdpdGggVU1MOgo+IAo+IG5vdGUgdGhhdCB0aGVy
ZSBhcmUgc3RhbmRhbG9uZSBwYXRjaGVzIGFzIHdlbGw6Cj4gCj4gIGh0dHA6Ly9wZW9wbGUucmVk
aGF0LmNvbS9taW5nby9sYXRlbmN5LXRyYWNpbmctcGF0Y2hlcy8KPiAKPiBzbyB0aGVyZSdzIG5v
IGZvcmNlZCBuZWVkIHRvIHVzZSAtcnQuCgpBaCwgZm9yZ290dGVuIGFib3V0IHRoYXQuCgpVbmZv
cnR1bmF0ZWx5IHRoZSBsYXRlbmN5IHRyYWNlciBwYXRjaCBkb2Vzbid0IGNvbXBpbGUgZWl0aGVy
OgoKICBDQyAgICAgIGtlcm5lbC9sYXRlbmN5X3RyYWNlLm8Ka2VybmVsL2xhdGVuY3lfdHJhY2Uu
YzoyODoyMTogZXJyb3I6IGFzbS9ydGMuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQprZXJu
ZWwvbGF0ZW5jeV90cmFjZS5jOjYzOjM6IGVycm9yOiAjZXJyb3IgSW1wbGVtZW50IGN5Y2xlc190
b191c2Vjcy4Ka2VybmVsL2xhdGVuY3lfdHJhY2UuYzogSW4gZnVuY3Rpb24g4oCYX19fX3RyYWNl
4oCZOgprZXJuZWwvbGF0ZW5jeV90cmFjZS5jOjY1ODogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uIOKAmGlycXNfZGlzYWJsZWRfZmxhZ3PigJkKbWFrZVsxXTogKioqIFtr
ZXJuZWwvbGF0ZW5jeV90cmFjZS5vXSBFcnJvciAxCgpNaWtsb3MKCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
U0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieTogVGhlIEZ1dHVyZSBvZiBMaW51eCBCdXNpbmVz
cyBXaGl0ZSBQYXBlcgpmcm9tIE5vdmVsbC4gIEZyb20gdGhlIGRlc2t0b3AgdG8gdGhlIGRhdGEg
Y2VudGVyLCBMaW51eCBpcyBnb2luZwptYWluc3RyZWFtLiAgTGV0IGl0IHNpbXBsaWZ5IHlvdXIg
SVQgZnV0dXJlLgpodHRwOi8vYWx0ZmFybS5tZWRpYXBsZXguY29tL2FkL2NrLzg4NTctNTAzMDct
MTg5MTgtNApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpV
c2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
