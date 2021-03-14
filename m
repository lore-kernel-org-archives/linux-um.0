Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLXUf-00EWHP-Kn
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 20:37:48 +0000
Message-ID: <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 21:37:40 +0100
In-Reply-To: <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

T24gV2VkLCAyMDIxLTAxLTIwIGF0IDExOjI3ICswOTAwLCBIYWppbWUgVGF6YWtpIHdyb3RlOgo+
IAo+IGRpZmYgLS1naXQgYS9hcmNoL3VtL0tjb25maWcgYi9hcmNoL3VtL0tjb25maWcKPiBpbmRl
eCAyNGM2NTk2MjYwZGUuLjVmYjZhODUyZDA1OCAxMDA2NDQKPiAtLS0gYS9hcmNoL3VtL0tjb25m
aWcKPiArKysgYi9hcmNoL3VtL0tjb25maWcKPiBAQCAtMjksNiArMjksMTAgQEAgY29uZmlnIFVN
TU9ERV9MSUIKPiDCoAlzZWxlY3QgVUFDQ0VTU19NRU1DUFkKPiDCoAlzZWxlY3QgQVJDSF9USFJF
QURfU1RBQ0tfQUxMT0NBVE9SCj4gwqAJc2VsZWN0IEFSQ0hfSEFTX1NZU0NBTExfV1JBUFBFUgo+
ICsJc2VsZWN0IFZGQVRfRlMKPiArCXNlbGVjdCBOTFNfQ09ERVBBR0VfNDM3Cj4gKwlzZWxlY3Qg
TkxTX0lTTzg4NTlfMQo+ICsJc2VsZWN0IEJUUkZTX0ZTCgpUaGF0IGRvZXNuJ3QgcmVhbGx5IHNl
ZW0gdG8gbWFrZSBzZW5zZSAtIHRoZSBzYW1wbGUgbWlnaHQgbmVlZCBpdCwgYnV0CmdlbmVyYWxs
eSBMS0wgZG9lc24ndC9zaG91bGRuJ3Q/Cgpqb2hhbm5lcwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K

