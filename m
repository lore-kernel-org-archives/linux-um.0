Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oatwD-009VNZ-2o
	for linux-um@lists.infradead.org; Wed, 21 Sep 2022 07:14:32 +0000
Date: Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <290835862.246902.1663744463482.JavaMail.zimbra@nod.at>
In-Reply-To: <20220921064855.2841607-1-davidgow@google.com>
References: <20220921064855.2841607-1-davidgow@google.com>
Subject: Re: [PATCH v2] arch: um: Mark the stack non-executable to fix a
 binutils warning
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
To: davidgow <davidgow@google.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>, tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, dave hansen <dave.hansen@linux.intel.com>, torvalds <torvalds@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kunit-dev <kunit-dev@googlegroups.com>, x86 <x86@kernel.org>, Lukas Straub <lukasstraub2@web.de>, Randy Dunlap <rdunlap@infradead.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImRhdmlkZ293IiA8ZGF2aWRn
b3dAZ29vZ2xlLmNvbT4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYxOgo+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL3BpcGVybWFpbC9saW51eC11bS8yMDIyLUF1Z3VzdC8wMDQyMzQuaHRtbAo+IC0g
UGFzcyB0aGUgLXogbm9leGVjc3RhY2sgYW5kIC0tbm8td2Fybi1yd3gtc2VnbWVudHMgZmxhZ3Mg
YXMgTERGTEFHUywKPiAgcmF0aGVyIHRoYW4gYXMgQ0ZMQUdTIHZpYSAtV2wKPiAtIENoZWNrIHRo
YXQgLS1uby13YXJuLXJ3eC1zZWdtZW50cyBleGlzdHMgd2l0aCB0aGUgbGQtb3B0aW9uIGZ1bmN0
aW9uCj4gIChUaGFua3MgUmljaGFyZCkKPiAtIEFkZCBMdWthcyBhbmQgUmFuZHkncyB0YWdzLgoK
Tm93IGl0IHBhc3NlcyB0aGUgdGVzdC4gOikKQXBwbGllZC4KClRoYW5rcywKLy9yaWNoYXJkCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

