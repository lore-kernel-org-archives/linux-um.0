Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dB5lh-0004gY-1K
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2017 20:42:01 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dB5lf-00069R-2U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2017 20:42:00 +0000
Message-ID: <1495053712.2984.5.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Wed, 17 May 2017 22:41:52 +0200
Mime-Version: 1.0
Subject: [uml-devel] [PATCH] um: Don't build arch/x86/um/user-offsets.s with
	gcc plugins
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Rm9yIHNvbWUgcmVhc29ucyBJIGRvbid0IGtub3cgdXNlcnMtb2Zmc2V0cy5zIGdldCdzIGJ1aWxk
IGJlZm9yZSB0aGUKZ2NjLXBsdWdpbnMgaXRzZWxmLgpUaGlzIHBhdGNoIGZpeGVzIHRoZSBwcm9i
bGVtIGJ5IG5vdCB1c2luZyB0aGUgZ2NjLXBsdWdpbnMgZm9yIGJ1aWxkaW5nCnVzZXItb2Zmc2V0
cy5zCgptYWtlIG9yZGVyIGV4YW1wbGU6CiQgbWFrZSBBUkNIPXVtCsKgIENIS8KgwqDCoMKgwqBp
bmNsdWRlL2dlbmVyYXRlZC91YXBpL2xpbnV4L3ZlcnNpb24uaArCoCBIT1NUQ0PCoMKgc2NyaXB0
cy9iYXNpYy9maXhkZXAKwqAgSE9TVENDwqDCoHNjcmlwdHMvYmFzaWMvYmluMmMKwqAgSE9TVEND
wqDCoHNjcmlwdHMvdW5pZmRlZgrCoCBDQ8KgwqDCoMKgwqDCoGFyY2gveDg2L3VtL3VzZXItb2Zm
c2V0cy5zCsKgIENIS8KgwqDCoMKgwqBpbmNsdWRlL2dlbmVyYXRlZC91c2VyX2NvbnN0YW50cy5o
CsKgIENIS8KgwqDCoMKgwqBpbmNsdWRlL2NvbmZpZy9rZXJuZWwucmVsZWFzZQrCoCBDSEvCoMKg
wqDCoMKgaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVsZWFzZS5oCsKgIEhPU1RDWFggLWZQSUMgc2Ny
aXB0cy9nY2MtcGx1Z2lucy9sYXRlbnRfZW50cm9weV9wbHVnaW4ubwrCoCBIT1NUTExEIC1zaGFy
ZWQgc2NyaXB0cy9nY2MtcGx1Z2lucy9sYXRlbnRfZW50cm9weV9wbHVnaW4uc28KwqAgSE9TVENY
WCAtZlBJQyBzY3JpcHRzL2djYy1wbHVnaW5zL3N0cnVjdGxlYWtfcGx1Z2luLm8KwqAgSE9TVExM
RCAtc2hhcmVkIHNjcmlwdHMvZ2NjLXBsdWdpbnMvc3RydWN0bGVha19wbHVnaW4uc28KClNpZ25l
ZC1vZmYtYnk6IFRob21hcyBNZXllciA8dGhvbWFzQG0zeTNyLmRlPgotLS0KwqBhcmNoL3g4Ni91
bS9NYWtlZmlsZSB8IDIgKy0KwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni91bS9NYWtlZmlsZSBiL2FyY2gveDg2L3Vt
L01ha2VmaWxlCmluZGV4IDQ2Y2JiZmUuLmQ2N2M3OGEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3Vt
L01ha2VmaWxlCisrKyBiL2FyY2gveDg2L3VtL01ha2VmaWxlCkBAIC0zNiw3ICszNiw3IEBAIHN1
YmFyY2gtJChDT05GSUdfTU9EVUxFUykgKz0gLi4va2VybmVsL21vZHVsZS5vCsKgVVNFUl9PQkpT
IDo9IGJ1Z3NfJChCSVRTKS5vIHB0cmFjZV91c2VyLm8gZmF1bHQubwrCoArCoGV4dHJhLXkgKz0g
dXNlci1vZmZzZXRzLnMKLSQob2JqKS91c2VyLW9mZnNldHMuczogY19mbGFncyA9IC1XcCwtTUQs
JChkZXBmaWxlKSAkKFVTRVJfQ0ZMQUdTKSBcCiskKG9iaikvdXNlci1vZmZzZXRzLnM6IGNfZmxh
Z3MgPSAtV3AsLU1ELCQoZGVwZmlsZSkgJChmaWx0ZXItb3V0ICQoR0NDX1BMVUdJTlNfQ0ZMQUdT
KSwgJChVU0VSX0NGTEFHUykgKSBcCsKgCS1JYXJjaC94ODYvaW5jbHVkZS9nZW5lcmF0ZWQKwqAK
wqBVTlBST0ZJTEVfT0JKUyA6PSBzdHViX3NlZ3YubwoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpD
aGVjayBvdXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdz
IG1vc3QKZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsv
c2xhc2hkb3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

