Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4Cv5-0004h7-98 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 21:51:47 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B4Cv0-0001g2-5l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 21:51:42 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Swapping directly to host swap area? 
In-Reply-To: <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0403190014030.2368-200000@sparrow>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="994229871-68930181-1079675498=:2368"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Mar 2004 00:51:38 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--994229871-68930181-1079675498=:2368
Content-Type: TEXT/PLAIN; charset=US-ASCII

Good morning, Jeff,

On Tue, 27 Jan 2004, Jeff Dike wrote:

> wstearns@pobox.com said:
> > In the current setup, the host kernel sees this as a normal
> > write to an open file, caching it in the process and so not truly
> > freeing up the ram for a bit. 
> 
> This is, and this could be done by setting O_DIRECT on UML swap devices.  That
> way, writes go directly (and asynchronously) to the device without landing
> in the cache.
> 
> With mmap in effect, this can also be done with a MADVISE_DONTNEED on the
> relevant pages of the swap file.
> 
> Patches cheerfully accepted.

	In that case, patch cheerfully submitted.  :-)
	The attached adds a fourth ubd option, "D".  When enabled, the 
open call for that ubd file will use the O_DIRECT option.  I didn't tackle 
the MADVISE portion, sorry.
	When I try to use it, I get back "cannot stat /dev/ubd/1: No 
such file or directory."  The file is, of course, there, and I've checked 
I'm using a kernel with this patch.  Does the Linux open64 not handle 
O_DIRECT?

	If the patch is mangled in transit or missing, it will also be up
at http://www.stearns.org/uml/ in a bit, along with a kernel compiled with 
this patch.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Where's the kaboom, there was supposed to be
an earth-shattering kaboom!"
        -- Marvin Martian
(Courtesy of John Green <johngreen@starband.net>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

--994229871-68930181-1079675498=:2368
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name="linux-2.6.4-uml2641-odirect.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0403190051380.2368@sparrow>
Content-Description: linux-2.6.4-uml2641-odirect.patch
Content-Disposition: attachment; filename="linux-2.6.4-uml2641-odirect.patch"

ZGlmZiAtdU5yIGxpbnV4LTIuNi40LXVtbDI2NDEub3JpZy9hcmNoL3VtL2Ry
aXZlcnMvdWJkX2tlcm4uYyBsaW51eC0yLjYuNC11bWwyNjQxLW9kaXJlY3Rz
d2FwLm9yaWcvYXJjaC91bS9kcml2ZXJzL3ViZF9rZXJuLmMNCi0tLSBsaW51
eC0yLjYuNC11bWwyNjQxLm9yaWcvYXJjaC91bS9kcml2ZXJzL3ViZF9rZXJu
LmMJU2F0IEZlYiAxNCAxNDowMDo0MyAyMDA0DQorKysgbGludXgtMi42LjQt
dW1sMjY0MS1vZGlyZWN0c3dhcC5vcmlnL2FyY2gvdW0vZHJpdmVycy91YmRf
a2Vybi5jCUZyaSBNYXIgMTkgMDA6MDg6MzMgMjAwNA0KQEAgLTE1LDYgKzE1
LDggQEANCiAgKiBvbmx5IC9kZXYvdWJkTi9kaXNjTiB0aGlzIHZlcnNpb24g
YWxzbyBoYXMgbG90cyBvZg0KICAqIGNsZWFuIHVwcyBwcmVwYXJpbmcgZm9y
IHViZC1tYW55Lg0KICAqIEphbWVzIE1jTWVjaGFuDQorICogMjAwNC0wMy0x
OSBBZGRpdGlvbiBvZiBPX0RJUkVDVCBvcHRpb24gJ0QnIGJ5DQorICogV2ls
bGlhbSBTdGVhcm5zICh3c3RlYXJuc0Bwb2JveC5jb20pDQogICovDQogDQog
I2RlZmluZSBNQUpPUl9OUiBVQkRfTUFKT1INCkBAIC0zMjYsNiArMzI4LDEw
IEBADQogCQlkZXYtPm5vX2NvdyA9IDE7DQogCQlzdHIrKzsNCiAJfQ0KKwlp
ZiAoKnN0ciA9PSAnRCcpew0KKwkJZmxhZ3MuZCA9IDE7DQorCQlzdHIrKzsN
CisJfQ0KIA0KIAlpZigqc3RyKysgIT0gJz0nKXsNCiAJCXByaW50ayhLRVJO
X0VSUiAidWJkX3NldHVwIDogRXhwZWN0ZWQgJz0nXG4iKTsNCkBAIC0zNjks
NyArMzc1LDEwIEBADQogIiAgICAwIHRvIDcuIEFwcGVuZGluZyBhbiAncicg
dG8gdGhlIG51bWJlciB3aWxsIGNhdXNlIHRoYXQgZGV2aWNlXG4iDQogIiAg
ICB0byBiZSBtb3VudGVkIHJlYWQtb25seS4gRm9yIGV4YW1wbGUgdWJkMXI9
Li9leHRfZnMuIEFwcGVuZGluZ1xuIg0KICIgICAgYW4gJ3MnIChoYXMgdG8g
YmUgX2FmdGVyXyAncicsIGlmIHRoZXJlIGlzIG9uZSkgd2lsbCBjYXVzZSBk
YXRhXG4iDQotIiAgICB0byBiZSB3cml0dGVuIHRvIGRpc2sgb24gdGhlIGhv
c3QgaW1tZWRpYXRlbHkuXG5cbiINCisiICAgIHRvIGJlIHdyaXR0ZW4gdG8g
ZGlzayBvbiB0aGUgaG9zdCBpbW1lZGlhdGVseS4gIFRoZSB0aGlyZCBvcHRp
b25cbiINCisiICAgICdkJyB0ZWxscyB1bWwgJ2RvIG5vdCB1c2UgYSBjb3cg
ZmlsZScgZm9yIHRoaXMgYmxvY2sgZGV2aWNlLlxuIg0KKyIgICAgRmluYWxs
eSwgJ0QnIHR1cm5zIG9uIERJUkVDVCBkaXNrIGFjY2Vzcywgd2hlcmUgdGhl
IGhvc3Qgd3JpdGVzXG4iDQorIiAgICB0aGUgZGF0YSBkaXJlY3RseSB3aXRo
IG5vIGNhY2hpbmcuICBHb29kIGZvciBzd2FwIGZpbGVzLlxuXG4iDQogKTsN
CiANCiBzdGF0aWMgaW50IGZha2VoZF9zZXQgPSAwOw0KZGlmZiAtdU5yIGxp
bnV4LTIuNi40LXVtbDI2NDEub3JpZy9hcmNoL3VtL2luY2x1ZGUvb3MuaCBs
aW51eC0yLjYuNC11bWwyNjQxLW9kaXJlY3Rzd2FwLm9yaWcvYXJjaC91bS9p
bmNsdWRlL29zLmgNCi0tLSBsaW51eC0yLjYuNC11bWwyNjQxLm9yaWcvYXJj
aC91bS9pbmNsdWRlL29zLmgJU2F0IEZlYiAxNCAxNDowMDo0MyAyMDA0DQor
KysgbGludXgtMi42LjQtdW1sMjY0MS1vZGlyZWN0c3dhcC5vcmlnL2FyY2gv
dW0vaW5jbHVkZS9vcy5oCVRodSBNYXIgMTggMjM6MjI6NDkgMjAwNA0KQEAg
LTUyLDEwICs1MiwxMiBAQA0KIAl1bnNpZ25lZCBpbnQgYSA6IDE7CS8qIE9f
QVBQRU5EICovDQogCXVuc2lnbmVkIGludCBlIDogMTsJLyogT19FWENMICov
DQogCXVuc2lnbmVkIGludCBjbCA6IDE7ICAgIC8qIEZEX0NMT0VYRUMgKi8N
CisJdW5zaWduZWQgaW50IGQgOiAxOwkvKiBPX0RJUkVDVCAqLw0KIH07DQog
DQogI2RlZmluZSBPUEVORkxBR1MoKSAoKHN0cnVjdCBvcGVuZmxhZ3MpIHsg
LnIgPSAwLCAudyA9IDAsIC5zID0gMCwgLmMgPSAwLCBcDQotIAkJCQkJICAu
dCA9IDAsIC5hID0gMCwgLmUgPSAwLCAuY2wgPSAwIH0pDQorIAkJCQkJICAu
dCA9IDAsIC5hID0gMCwgLmUgPSAwLCAuY2wgPSAwLCBcDQorCQkJCQkgIC5k
ID0gMCB9KQ0KIA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IG9wZW5mbGFncyBv
Zl9yZWFkKHN0cnVjdCBvcGVuZmxhZ3MgZmxhZ3MpDQogew0KQEAgLTExNiw2
ICsxMTgsMTIgQEANCiAJZmxhZ3MuY2wgPSAxOyANCiAJcmV0dXJuKGZsYWdz
KTsgDQogfQ0KKw0KK3N0YXRpYyBpbmxpbmUgc3RydWN0IG9wZW5mbGFncyBv
Zl9kaXJlY3Qoc3RydWN0IG9wZW5mbGFncyBmbGFncykNCit7IA0KKwlmbGFn
cy5kID0gMTsgDQorCXJldHVybihmbGFncyk7IA0KK30NCiAgIA0KIGV4dGVy
biBpbnQgb3Nfc3RhdF9maWxlKGNvbnN0IGNoYXIgKmZpbGVfbmFtZSwgc3Ry
dWN0IHVtbF9zdGF0ICpidWYpOw0KIGV4dGVybiBpbnQgb3Nfc3RhdF9mZChj
b25zdCBpbnQgZmQsIHN0cnVjdCB1bWxfc3RhdCAqYnVmKTsNCmRpZmYgLXVO
ciBsaW51eC0yLjYuNC11bWwyNjQxLm9yaWcvYXJjaC91bS9vcy1MaW51eC9m
aWxlLmMgbGludXgtMi42LjQtdW1sMjY0MS1vZGlyZWN0c3dhcC5vcmlnL2Fy
Y2gvdW0vb3MtTGludXgvZmlsZS5jDQotLS0gbGludXgtMi42LjQtdW1sMjY0
MS5vcmlnL2FyY2gvdW0vb3MtTGludXgvZmlsZS5jCVNhdCBGZWIgMTQgMTQ6
MDA6NDMgMjAwNA0KKysrIGxpbnV4LTIuNi40LXVtbDI2NDEtb2RpcmVjdHN3
YXAub3JpZy9hcmNoL3VtL29zLUxpbnV4L2ZpbGUuYwlUaHUgTWFyIDE4IDIz
OjI0OjQwIDIwMDQNCkBAIC0yNjUsNiArMjY1LDcgQEANCiAJaWYoZmxhZ3Mu
YykgZiB8PSBPX0NSRUFUOw0KIAlpZihmbGFncy50KSBmIHw9IE9fVFJVTkM7
DQogCWlmKGZsYWdzLmUpIGYgfD0gT19FWENMOw0KKwlpZihmbGFncy5kKSBm
IHw9IE9fRElSRUNUOw0KIA0KIAlmZCA9IG9wZW42NChmaWxlLCBmLCBtb2Rl
KTsNCiAJaWYoZmQgPCAwKQ0K
--994229871-68930181-1079675498=:2368--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
