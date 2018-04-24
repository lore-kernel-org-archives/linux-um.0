Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fB62R-0003bS-Fb
 for linux-um@lists.infradead.org; Tue, 24 Apr 2018 22:03:52 +0000
Received: by mail-ua0-x241.google.com with SMTP id v4so13623877uaj.3
 for <linux-um@lists.infradead.org>; Tue, 24 Apr 2018 15:03:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-19-ebiederm@xmission.com>
 <7074fe36-27c5-ee82-9659-da703cfc91fe@kot-begemot.co.uk>
 <CAFLxGvyM+Kru=ERDvccjVuMjSPbu+FQzjbUbMwSyEbL1rVGkBQ@mail.gmail.com>
 <7ddd238f-88a8-ed03-fe9e-0f4e5f2a490d@kot-begemot.co.uk>
 <87zi1sd28d.fsf@xmission.com>
 <CAMD8JhwgcWCp6c=O4-spNW1VdY5M-eAjr7M5PieeAfeTSe_4yw@mail.gmail.com>
From: =?UTF-8?Q?Martin_P=C3=A4rtel?= <martin.partel@gmail.com>
Date: Wed, 25 Apr 2018 01:03:39 +0300
Message-ID: <CAMD8JhxHwcuXh68o1=fbZ_t6DH7x_dO_0nEMqL=cHXBfZXub=w@mail.gmail.com>
Subject: Re: [uml-devel] [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault
 in relay_signal.
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

QW5kIG9uY2UgbW9yZSBpbiBwbGFpbiB0ZXh0Li4KCk9uIDI1IEFwcmlsIDIwMTggYXQgMDE6MDAs
IE1hcnRpbiBQw6RydGVsIDxtYXJ0aW4ucGFydGVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBh
bGwsCj4KPiBUaGlzIHdhcyBhZ2VzIGFnbywgYnV0IGZyb20gd2hhdCBJIHJlbWVtYmVyLi4uCj4K
Pj4KPj4gSGF2aW5nIGEgc2Vjb25kIGxvb2sgSSByZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IHJlbGF5X3NpZ25hbCBpcwo+PiB0cnlpbmcgdG8gZG8uCj4+Cj4+IFRoZSBmdW5jdGlvbiByZWxh
eV9zaWduYWwgZG9lcyBub3QgcGFzcyBzaWdpbmZvIHRocm91Z2ggdW5jaGFuZ2VkLgo+Cj4KPiBK
dXN0IGNvcHlpbmcgdGhlIGVudGlyZSBzdHJ1Y3Qgd291bGQgZG8gdGhlIHdyb25nIHRoaW5nLiBJ
dCB3YXMgZGlzY3Vzc2VkIGhlcmU6Cj4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9dXNlci1tb2RlLWxp
bnV4LWRldmVsJm09MTMzOTEwNzA3OTExOTk5Jnc9Mgo+Cj4+Cj4+IEFtIEkgbWlzc2luZyBzb21l
dGhpbmcgc3VidGxlIG9yIGhhdmUgdGhlIHN1YnRsZSBkZXRhaWxzIG9mIHNpZ2luZm8ganVzdAo+
PiBhbHdheXMgYmVlbiBpZ25vcmVkPwo+Cj4KPiBNeSBndWVzcyBpcyB0aGV5IGhhdmUuIEkgd2Fz
IGFsbW9zdCBjZXJ0YWlubHkgb2JsaXZpb3VzIHRvIHN1Y2ggc3VidGxldGllcyB3aGVuIHdyaXRp
bmcgbXkgY29tbWl0Lgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

