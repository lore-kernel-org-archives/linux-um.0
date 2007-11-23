Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvUNl-0001P4-ST for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 00:59:29 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IvUNk-0007mt-Bj
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 00:59:29 -0800
In-reply-to: <20071122235141.GA7876@c2.user-mode-linux.org> (message from Jeff
	Dike on Thu, 22 Nov 2007 18:51:41 -0500)
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
	<20071114173639.GA7899@c2.user-mode-linux.org>
	<E1IsPo5-0008RU-00@dorka.pomaz.szeredi.hu>
	<20071116170630.GA9299@c2.user-mode-linux.org>
	<E1IvGTn-0007cC-7q@dorka.pomaz.szeredi.hu>
	<20071122235141.GA7876@c2.user-mode-linux.org>
MIME-version: 1.0
Message-Id: <E1IvUNW-0000a5-Vg@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Nov 2007 09:59:14 +0100
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
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
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

PiBPbiBUaHUsIE5vdiAyMiwgMjAwNyBhdCAwNzowODo0N1BNICswMTAwLCBNaWtsb3MgU3plcmVk
aSB3cm90ZToKPiA+IFRoYW5rcy4gIE15IG90aGVyIHByb2JsZW0gaXMgKHByb2JhYmx5IHlvdSBh
cmUgYXdhcmUpIHRoYXQgcmVjZW50IC1tbQo+ID4ga2VybmVscyBkb24ndCBjb21waWxlIGZvciBV
TUwuCj4gCj4gVGhlIHBhdGNoIGJlbG93IGZpeGVzIHRoZSBidWlsZCBmb3IgcmMzLW1tMSBmb3Ig
bWUuCgpZZWFoLCBJIGdvdCBhcyBmYXIgYXMgdGhhdCAoc29ycnkgYWJvdXQgdGhlIGluY29tcGxl
dGUgcmVwb3J0KSwgYnV0CnRoZW4gSSBnb3Qgc3R1Y2sgb24gdGhpczoKCiAgQ0MgICAgICBhcmNo
L3VtL2tlcm5lbC9hc20tb2Zmc2V0cy5zCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2Fz
bS9hcmNoL2F0b21pYy5oOjIsCiAgICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2FzbS9hdG9t
aWMuaDo5LAogICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjMz
MywKICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvc2VxbG9jay5oOjI5LAogICAg
ICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC90aW1lLmg6OCwKICAgICAgICAgICAgICAg
ICBmcm9tIGluY2x1ZGUvbGludXgvdGltZXguaDo1NywKICAgICAgICAgICAgICAgICBmcm9tIGlu
Y2x1ZGUvbGludXgvc2NoZWQuaDo1MywKICAgICAgICAgICAgICAgICBmcm9tIGFyY2gvdW0vaW5j
bHVkZS9zeXNkZXAva2VybmVsLW9mZnNldHMuaDoyLAogICAgICAgICAgICAgICAgIGZyb20gYXJj
aC91bS9rZXJuZWwvYXNtLW9mZnNldHMuYzoxOgppbmNsdWRlL2FzbS9hcmNoL2F0b21pY18zMi5o
OiBJbiBmdW5jdGlvbiDigJhhdG9taWNfYWRkX3VubGVzc+KAmToKaW5jbHVkZS9hc20vYXJjaC9h
dG9taWNfMzIuaDoyNDE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVt
YmVyIG5hbWVkIOKAmHg4NuKAmQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVkZS9hc20vcndz
ZW0uaDo0LAogICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9yd3NlbS5oOjI0LAog
ICAgICAgICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9tbV90eXBlcy5oOjExLAogICAgICAg
ICAgICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9zY2hlZC5oOjYwLAogICAgICAgICAgICAgICAg
IGZyb20gYXJjaC91bS9pbmNsdWRlL3N5c2RlcC9rZXJuZWwtb2Zmc2V0cy5oOjIsCiAgICAgICAg
ICAgICAgICAgZnJvbSBhcmNoL3VtL2tlcm5lbC9hc20tb2Zmc2V0cy5jOjE6CmluY2x1ZGUvYXNt
L2FyY2gvcndzZW0uaDogSW4gZnVuY3Rpb24g4oCYX19kb3duX3dyaXRlX3RyeWxvY2vigJk6Cmlu
Y2x1ZGUvYXNtL2FyY2gvcndzZW0uaDoxNjU6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKA
mSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4NuKAmQoKU2FtZSBjb25maWcgSSBzZW50IHByZXZp
b3VzbHkuCgpNaWtsb3MKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3Bv
bnNvcmVkIGJ5OiBNaWNyb3NvZnQKRGVmeSBhbGwgY2hhbGxlbmdlcy4gTWljcm9zb2Z0KFIpIFZp
c3VhbCBTdHVkaW8gMjAwNS4KaHR0cDovL2Nsay5hdGRtdC5jb20vTVJUL2dvL3ZzZTAxMjAwMDAw
NzBtcnQvZGlyZWN0LzAxLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51
eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
