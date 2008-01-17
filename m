Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFZuV-0000Nx-E1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:56:19 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFZuU-0000bH-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:56:19 -0800
Date: Thu, 17 Jan 2008 10:56:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080117105606.ff89e9e9.akpm@linux-foundation.org>
In-Reply-To: <200801171911.16230.m.kozlowski@tuxland.pl>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117135641.GD2693@hacking>
	<200801171911.16230.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Subject: Re: [uml-devel] [-mm Patch] uml: fix a building error
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
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff@sc8-sf-spam2-b.sourceforge.net, Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, sparclinux@vger.kernel.org, WANG Cong <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>

T24gVGh1LCAxNyBKYW4gMjAwOCAxOToxMToxMyArMDEwMCBNYXJpdXN6IEtvemxvd3NraSA8bS5r
b3psb3dza2lAdHV4bGFuZC5wbD4gd3JvdGU6Cgo+IEhlbGxvLAo+IAo+ID4gVGhpcyBwYXRjaCBm
aXhlcyB0aGlzIGJ1aWxkaW5nIGVycm9yOgo+ID4gLi4uCj4gPiBkcml2ZXJzL2NoYXIvbWVtLmM6
IEluIGZ1bmN0aW9uIOKAmHJlYWRfbWVt4oCZOgo+ID4gZHJpdmVycy9jaGFyL21lbS5jOjEzNjog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHVueGxhdGVfZGV2X21l
bV9wdHLigJkKPiA+IC4uLgo+IAo+IEkgc2VlIHRoaXMgb24gc3BhcmM2NCBhcyB3ZWxsOgo+IAo+
ICAgQ0MgICAgICBkcml2ZXJzL2NoYXIvbWVtLm8KPiBkcml2ZXJzL2NoYXIvbWVtLmM6IEluIGZ1
bmN0aW9uICdyZWFkX21lbSc6Cj4gZHJpdmVycy9jaGFyL21lbS5jOjEzNjogZXJyb3I6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICd1bnhsYXRlX2Rldl9tZW1fcHRyJwo+IG1ha2Vb
Ml06ICoqKiBbZHJpdmVycy9jaGFyL21lbS5vXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFtkcml2
ZXJzL2NoYXJdIEVycm9yIDIKPiBtYWtlOiAqKiogW2RyaXZlcnNdIEVycm9yIDIKPiAKPiBEb2Vz
IHNwYXJjNjQgbmVlZCBzaW1pbGFyIGZpeD8KPiAKClRoZSBQQVQgcGF0Y2hlcyBzdHJpa2UgYWdh
aW4uCgpJbmdvLCBJIHRoaW5rIHlvdSBtaWdodCBuZWVkIHRvIHRvc3Mgc29tZSBjcm9zcy1jb21w
aWxlcnMgaW50byB0aGF0IGJ1aWxkCnRlc3Qgc2V0dXAgb2YgeW91cnMuCgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnk6IE1pY3Jvc29mdApEZWZ5IGFs
bCBjaGFsbGVuZ2VzLiBNaWNyb3NvZnQoUikgVmlzdWFsIFN0dWRpbyAyMDA4LgpodHRwOi8vY2xr
LmF0ZG10LmNvbS9NUlQvZ28vdnNlMDEyMDAwMDA3MG1ydC9kaXJlY3QvMDEvCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZl
bCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUt
bGludXgtZGV2ZWwK
