Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdAUT-00025G-1A
 for linux-um@lists.infradead.org; Thu, 12 Nov 2020 11:10:10 +0000
Date: Thu, 12 Nov 2020 12:09:57 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1031007630.296676.1605179397893.JavaMail.zimbra@nod.at>
In-Reply-To: <20201112103337.4862-1-anton.ivanov@cambridgegreys.com>
References: <20201112103337.4862-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v2] um: enable the use of optimized xor routines in UML
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
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>

QW50b24sCgotLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4gVm9uOiAiYW50b24gaXZh
bm92IiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBBbjogImxpbnV4LXVtIiA8
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4KPiBDQzogInJpY2hhcmQiIDxyaWNoYXJkQG5v
ZC5hdD4sICJhbnRvbiBpdmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+
IEdlc2VuZGV0OiBEb25uZXJzdGFnLCAxMi4gTm92ZW1iZXIgMjAyMCAxMTozMzozNwo+IEJldHJl
ZmY6IFtQQVRDSCB2Ml0gdW06IGVuYWJsZSB0aGUgdXNlIG9mIG9wdGltaXplZCB4b3Igcm91dGlu
ZXMgaW4gVU1MCgo+IEZyb206IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdy
ZXlzLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGVuYWJsZSB0aGUgdXNlIG9mIG9wdGltaXplZCB4b3Ig
cm91dGluZXMgZnJvbSB0aGUgeDg2Cj4gdHJlZSBhcyB3ZWxsIGFzIHN1cHBseSB0aGUgbmVjZXNz
YXJ5IG1hY3JvcyBmb3IgdGhlbSB0byBiZSB1c2VkIGluCj4gVU1MLgo+IAo+IFRoZSBtYWNyb3Mg
c3VwcGx5IHNldmVyYWwgImZha2UiIGZsYWdzIGFuZCBkZWZpbml0aW9ucyB0byBhbGxvdwo+IHVz
aW5nIHRoZSB4ODYgZmlsZXMgImFzIGlzIi4KPiAKPiBUaGlzIHBhdGNoc2V0IGltcGxlbWVudHMg
b25seSB0aGUgZmxhZ3MgbmVlZGVkIGZvciB0aGUgb3B0aW1pemVkCj4gc3RyaW5ncy5oLCB4b3Iu
aCBhbmQgY2hlY2tzdW0uaCBpbXBsZW1lbnRhdGlvbnMgaW5zdGVhZCBvZgo+IHRyeWluZyB0byBj
b3B5IHRoZSBlbnRpcmUgeDg2IGZsYWdzIGVudmlyb25tZW50LgoKU28sIHRoZSBwbGFuIGlzIHVz
aW5nIHhvciBtZXRob2RzIGZyb20gYXJjaC94ODYgYW5kIHN0cmluZyBtZXRob2RzCmZyb20gZ2xp
YmM/CgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=

