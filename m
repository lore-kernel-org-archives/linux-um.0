Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Sun, 18 Sep 2022 23:19:41 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
In-Reply-To: <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com> <20220819221731.480795-5-gpiccoli@igalia.com> <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
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
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, kexec@lists.infradead.org, bhe@redhat.com, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, netdev <netdev@vger.kernel.org>, x86 <x86@kernel.org>, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro j jimenez <alejandro.j.jimenez@oracle.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d hatayama <d.hatayama@jp.fujitsu.com>, dave hansen <dave.hansen@linux.intel.com>, dyoung@redhat.com, feng tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, jgross@suse.com, John Ogness <john.ogness@linutronix.de>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, mhiramat@kernel.org, mingo <mingo@redhat.com>, paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com, anton ivanov <anton.ivanov@cambridgegreys.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkd1aWxoZXJtZSBHLiBQaWNj
b2xpIiA8Z3BpY2NvbGlAaWdhbGlhLmNvbT4KPiBPbiAxOS8wOC8yMDIyIDE5OjE3LCBHdWlsaGVy
bWUgRy4gUGljY29saSB3cm90ZToKPj4gQ3VycmVudGx5IHRoZSBwYW5pYyBub3RpZmllcnMgZnJv
bSB1c2VyIG1vZGUgbGludXggZG9uJ3QgZm9sbG93Cj4+IHRoZSBjb252ZW50aW9uIGZvciBtb3N0
IG9mIHRoZSBvdGhlciBub3RpZmllcnMgcHJlc2VudCBpbiB0aGUKPj4ga2VybmVsIChpbmRlbnRh
dGlvbiwgcHJpb3JpdHkgc2V0dGluZywgbnVtZXJpYyByZXR1cm4pLgo+PiBNb3JlIGltcG9ydGFu
dCwgdGhlIHByaW9yaXRpZXMgY291bGQgYmUgaW1wcm92ZWQsIHNpbmNlIGl0J3MgYQo+PiBzcGVj
aWFsIGNhc2UgKHVzZXJzcGFjZSksIGhlbmNlIHdlIGNvdWxkIHJ1biB0aGUgbm90aWZpZXJzIGVh
cmxpZXI7Cj4+IHVzZXIgbW9kZSBsaW51eCBzaG91bGRuJ3QgY2FyZSBtdWNoIHdpdGggb3RoZXIg
cGFuaWMgbm90aWZpZXJzIGJ1dAo+PiB0aGUgb3JkZXJpbmcgYW1vbmcgdGhlIG1jb25zb2xlIGFu
ZCBhcmNoIG5vdGlmaWVyIGlzIGltcG9ydGFudCwKPj4gZ2l2ZW4gdGhhdCB0aGUgYXJjaCBvbmUg
ZWZmZWN0aXZlbHkgdHJpZ2dlcnMgYSBjb3JlIGR1bXAuCj4+IAo+PiBGaXggdGhhdCBieSBydW5u
aW5nIHRoZSBtY29uc29sZSBub3RpZmllciBhcyB0aGUgZmlyc3QgcGFuaWMKPj4gbm90aWZpZXIs
IGZvbGxvd2VkIGJ5IHRoZSBhcmNoaXRlY3R1cmUgb25lICh0aGF0IGNvcmVkdW1wcykuCj4+IAo+
PiBDYzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+PiBD
YzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KPj4gQ2M6IFJpY2hh
cmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4+IFNpZ25lZC1vZmYtYnk6IEd1aWxoZXJt
ZSBHLiBQaWNjb2xpIDxncGljY29saUBpZ2FsaWEuY29tPgo+PiAKPj4gVjM6Cj4+IC0gTm8gY2hh
bmdlcy4KPj4gWy4uLl0KPiAKPiBIaSBKb2hhbm5lcywgc29ycnkgZm9yIHRoZSBwaW5nLiBEbyB5
b3UgdGhpbmsgeW91IGNvdWxkIHBpY2sgdGhpcyBvbmU/Cj4gT3IgaWYgeW91IHByZWZlciwgSSBj
YW4gcmVzZW5kIGl0IGFsb25lIChub3QgaW4gdGhlIHNlcmllcykgLSBsZXQgbWUKPiBrbm93IHlv
dXIgcHJlZmVyZW5jZS4KClRoaXMgcGF0Y2ggaXMgb24gbXkgVE9ETyBsaXN0LgpKdXN0IGhhZCBu
byBjaGFuY2UgdG8gdGVzdCBpdC4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

