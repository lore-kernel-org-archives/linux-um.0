Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLgry-008nRM-BU
 for linux-um@lists.infradead.org; Thu, 02 Sep 2021 07:10:44 +0000
Message-ID: <626cc3f828c2dab14cd66e8cac0c8ea84e7ba088.camel@sipsolutions.net>
Subject: Re: [PATCH] drm/r128: fix build for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 02 Sep 2021 09:10:20 +0200
In-Reply-To: <20210902021721.27274-1-rdunlap@infradead.org>
References: <20210902021721.27274-1-rdunlap@infradead.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

T24gV2VkLCAyMDIxLTA5LTAxIGF0IDE5OjE3IC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4g
Rml4IGEgYnVpbGQgZXJyb3Igb24gQ09ORklHX1VNTCwgd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCAo
cHJvdmlkZSkKPiB3YmludmQoKS4gVU1MIGNhbiB1c2UgdGhlIGdlbmVyaWMgbWIoKSBpbnN0ZWFk
Lgo+IAo+IC4uL2RyaXZlcnMvZ3B1L2RybS9yMTI4L2F0aV9wY2lnYXJ0LmM6IEluIGZ1bmN0aW9u
IOKAmGRybV9hdGlfcGNpZ2FydF9pbml04oCZOgo+IC4uL2RyaXZlcnMvZ3B1L2RybS9yMTI4L2F0
aV9wY2lnYXJ0LmM6MjE4OjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biDigJh3YmludmTigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4g
wqDCoHdiaW52ZCgpOwo+IMKgwqBefn5+fn4KPiAKPiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpICMgcHJlLWdpdAoKQXJndWFibHksIHRoYXQgY291bGQgYmUKCkZpeGVz
OiA2OGY1ZDNmM2I2NTQgKCJ1bTogYWRkIFBDSSBvdmVyIHZpcnRpbyBlbXVsYXRpb24gZHJpdmVy
IikKCmJlY2F1c2UgcHJpb3IgdG8gdGhhdCwgS2NvbmZpZyBvcHRpb25zIGRlcGVuZGluZyBvbiBQ
Q0kgY291bGRuJ3QgYmUKc2VsZWN0ZWQgb24gQVJDSD11bS4KCmpvaGFubmVzCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

