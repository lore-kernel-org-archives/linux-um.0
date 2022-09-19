Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <11701672-998b-4292-6885-8ac26e16478e@igalia.com>
Date: Mon, 19 Sep 2022 08:44:21 -0300
MIME-Version: 1.0
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-5-gpiccoli@igalia.com>
 <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
 <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, kexec@lists.infradead.org, bhe@redhat.com, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, netdev <netdev@vger.kernel.org>, x86 <x86@kernel.org>, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro j jimenez <alejandro.j.jimenez@oracle.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d hatayama <d.hatayama@jp.fujitsu.com>, dave hansen <dave.hansen@linux.intel.com>, dyoung@redhat.com, feng tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, jgross@suse.com, John Ogness <john.ogness@linutronix.de>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, mhiramat@kernel.org, mingo <mingo@redhat.com>, paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com, anton ivanov <anton.ivanov@cambridgegreys.com>

T24gMTgvMDkvMjAyMiAxODoxOSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4gVm9uOiAiR3VpbGhlcm1lIEcuIFBpY2NvbGkiIDxn
cGljY29saUBpZ2FsaWEuY29tPgo+PiBPbiAxOS8wOC8yMDIyIDE5OjE3LCBHdWlsaGVybWUgRy4g
UGljY29saSB3cm90ZToKPj4+IEN1cnJlbnRseSB0aGUgcGFuaWMgbm90aWZpZXJzIGZyb20gdXNl
ciBtb2RlIGxpbnV4IGRvbid0IGZvbGxvdwo+Pj4gdGhlIGNvbnZlbnRpb24gZm9yIG1vc3Qgb2Yg
dGhlIG90aGVyIG5vdGlmaWVycyBwcmVzZW50IGluIHRoZQo+Pj4ga2VybmVsIChpbmRlbnRhdGlv
biwgcHJpb3JpdHkgc2V0dGluZywgbnVtZXJpYyByZXR1cm4pLgo+Pj4gTW9yZSBpbXBvcnRhbnQs
IHRoZSBwcmlvcml0aWVzIGNvdWxkIGJlIGltcHJvdmVkLCBzaW5jZSBpdCdzIGEKPj4+IHNwZWNp
YWwgY2FzZSAodXNlcnNwYWNlKSwgaGVuY2Ugd2UgY291bGQgcnVuIHRoZSBub3RpZmllcnMgZWFy
bGllcjsKPj4+IHVzZXIgbW9kZSBsaW51eCBzaG91bGRuJ3QgY2FyZSBtdWNoIHdpdGggb3RoZXIg
cGFuaWMgbm90aWZpZXJzIGJ1dAo+Pj4gdGhlIG9yZGVyaW5nIGFtb25nIHRoZSBtY29uc29sZSBh
bmQgYXJjaCBub3RpZmllciBpcyBpbXBvcnRhbnQsCj4+PiBnaXZlbiB0aGF0IHRoZSBhcmNoIG9u
ZSBlZmZlY3RpdmVseSB0cmlnZ2VycyBhIGNvcmUgZHVtcC4KPj4+Cj4+PiBGaXggdGhhdCBieSBy
dW5uaW5nIHRoZSBtY29uc29sZSBub3RpZmllciBhcyB0aGUgZmlyc3QgcGFuaWMKPj4+IG5vdGlm
aWVyLCBmb2xsb3dlZCBieSB0aGUgYXJjaGl0ZWN0dXJlIG9uZSAodGhhdCBjb3JlZHVtcHMpLgo+
Pj4KPj4+IENjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+
Cj4+PiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPj4+IENj
OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
R3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+Cj4+Pgo+Pj4gVjM6Cj4+
PiAtIE5vIGNoYW5nZXMuCj4+PiBbLi4uXQo+Pgo+PiBIaSBKb2hhbm5lcywgc29ycnkgZm9yIHRo
ZSBwaW5nLiBEbyB5b3UgdGhpbmsgeW91IGNvdWxkIHBpY2sgdGhpcyBvbmU/Cj4+IE9yIGlmIHlv
dSBwcmVmZXIsIEkgY2FuIHJlc2VuZCBpdCBhbG9uZSAobm90IGluIHRoZSBzZXJpZXMpIC0gbGV0
IG1lCj4+IGtub3cgeW91ciBwcmVmZXJlbmNlLgo+IAo+IFRoaXMgcGF0Y2ggaXMgb24gbXkgVE9E
TyBsaXN0Lgo+IEp1c3QgaGFkIG5vIGNoYW5jZSB0byB0ZXN0IGl0Lgo+IAo+IFRoYW5rcywKPiAv
L3JpY2hhcmQKClRoYW5rcyBhIGxvdCBSaWNoYXJkIQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=

