Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KL2NS-0000QY-Oh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 13:53:02 -0700
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]
	helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KL2NQ-0006NX-O9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 13:53:02 -0700
Date: Mon, 21 Jul 2008 17:32:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20080721173226.0c0462f7@the-village.bc.nu>
In-Reply-To: <20080721165409.GA9023@hack.voiplan.pt>
References: <20080721165409.GA9023@hack.voiplan.pt>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] um: fix a build error
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

T24gTW9uLCAyMSBKdWwgMjAwOCAxNzo1NDowOSArMDEwMApXQU5HIENvbmcgPHhpeW91Lndhbmdj
b25nQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IAo+IEZpeGVkIHRoaXMgYnVpbGQgZXJyb3I6Cj4gCj4g
L2hvbWUvd2FuZ2NvbmcvUHJvamVjdHMvbGludXgtMi42L2FyY2gvdW0vZHJpdmVycy9saW5lLmM6
IEluIGZ1bmN0aW9uCj4g4oCYbGluZV93cml0ZV9pbnRlcnJ1cHTigJk6Cj4gL2hvbWUvd2FuZ2Nv
bmcvUHJvamVjdHMvbGludXgtMi42L2FyY2gvdW0vZHJpdmVycy9saW5lLmM6MzY2OiBlcnJvcjoK
PiDigJhzdHJ1Y3QgdHR5X2xkaXNj4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYd3JpdGVfd2Fr
ZXVw4oCZCj4gL2hvbWUvd2FuZ2NvbmcvUHJvamVjdHMvbGludXgtMi42L2FyY2gvdW0vZHJpdmVy
cy9saW5lLmM6MzY3OiBlcnJvcjoKPiDigJhzdHJ1Y3QgdHR5X2xkaXNj4oCZIGhhcyBubyBtZW1i
ZXIgbmFtZWQg4oCYd3JpdGVfd2FrZXVw4oCZCj4gbWFrZVsyXTogKioqIFthcmNoL3VtL2RyaXZl
cnMvbGluZS5vXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFthcmNoL3VtL2RyaXZlcnNdIEVycm9y
IDIKPiBtYWtlOiAqKiogW3N1Yi1tYWtlXSBFcnJvciAyCj4gCj4gU2lnZW5kLW9mZi1ieTogV0FO
RyBDb25nIDx3YW5nY29uZ0B6ZXV1eC5vcmc+CgpOQUsgLSBkcml2ZXJzIHNob3VsZG4ndCBiZSBw
b2tpbmcgYXJvdW5kIGluIHR0eSBpbm5hcmRzIGluIHRoZSBmaXJzdApwbGFjZSB0aGVuIHRoaXMg
d291bGRuJ3QgYnJlYWsuIFVzZSB0dHlfd2FrZXVwKHR0eSk7IGluc3RlYWFkCgpBbGFuCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUgTW9ibGlu
IFlvdXIgTW92ZSBEZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3QgTGludXgg
YmFzZWQgYXBwbGljYXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdpbiBncmVhdCBwcml6ZXMKR3Jh
bmQgcHJpemUgaXMgYSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQgYW55d2hl
cmUgaW4gdGhlIHdvcmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5vcmcvcmVkaXJlY3QucGhwP2Jh
bm5lcl9pZD0xMDAmdXJsPS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGlu
dXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
