Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJbdZ-0001cB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 08:45:05 -0800
Received: from m17.lax.untd.com ([64.136.30.80])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AJbdZ-0003Bq-1p
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 11 Nov 2003 08:45:05 -0800
Message-ID: <20031111.084000.-502533.0.mcmechanjw@juno.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=--__JNP_000_348b.1d93.6b9a
From: James W McMechan <mcmechanjw@juno.com>
Subject: [uml-devel] Slight host audio problem in 2.4.22-6
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 11 Nov 2003 08:39:46 -0800
To: user-mode-linux-devel@lists.sourceforge.net


This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_348b.1d93.6b9a
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

While compiling my standard options I got

hostaudio_kern.c:51: parse error before "DSP_HELP"
hostaudio_kern.c:54: parse error before "MIXER_HELP"
make[1]: *** [hostaudio_kern.o] Error 1
make[1]: Leaving directory `/home/uml/work-2.4.22-6/arch/um/drivers'

The new help defines were only in the non module part of the #ifndef
attached patch to move it before the whole #ifndef so it should work
both as a module and built-in

Enjoy,

James McMechan
----__JNP_000_348b.1d93.6b9a
Content-Type: application/octet-stream; name="host_audio"
Content-Transfer-Encoding: base64

ZGlmZiAtTnVyIHVtbC0yLjQuMjItNi9hcmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4uYyB3
b3JrLTIuNC4yMi02L2FyY2gvdW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vybi5jCi0tLSB1bWwtMi40
LjIyLTYvYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLmMJMjAwMy0xMS0xMSAwNjo1MTow
Ni4wMDAwMDAwMDAgLTA4MDAKKysrIHdvcmstMi40LjIyLTYvYXJjaC91bS9kcml2ZXJzL2hvc3Rh
dWRpb19rZXJuLmMJMjAwMy0xMS0xMSAwODozMToyNS4wMDAwMDAwMDAgLTA4MDAKQEAgLTIwLDYg
KzIwLDE0IEBACiBjaGFyICpkc3AgPSBIT1NUQVVESU9fREVWX0RTUDsKIGNoYXIgKm1peGVyID0g
SE9TVEFVRElPX0RFVl9NSVhFUjsKIAorI2RlZmluZSBEU1BfSEVMUCBcCisiICAgIFRoaXMgaXMg
dXNlZCB0byBzcGVjaWZ5IHRoZSBob3N0IGRzcCBkZXZpY2UgdG8gdGhlIGhvc3RhdWRpbyBkcml2
ZXIuXG4iIFwKKyIgICAgVGhlIGRlZmF1bHQgaXMgXCIiIEhPU1RBVURJT19ERVZfRFNQICJcIi5c
blxuIgorCisjZGVmaW5lIE1JWEVSX0hFTFAgXAorIiAgICBUaGlzIGlzIHVzZWQgdG8gc3BlY2lm
eSB0aGUgaG9zdCBtaXhlciBkZXZpY2UgdG8gdGhlIGhvc3RhdWRpbyBkcml2ZXIuXG4iIFwKKyIg
ICAgVGhlIGRlZmF1bHQgaXMgXCIiIEhPU1RBVURJT19ERVZfTUlYRVIgIlwiLlxuXG4iCisKICNp
Zm5kZWYgTU9EVUxFCiBzdGF0aWMgaW50IHNldF9kc3AoY2hhciAqbmFtZSwgaW50ICphZGQpCiB7
CkBAIC0yNywxMCArMzUsNiBAQAogCXJldHVybigwKTsKIH0KIAotI2RlZmluZSBEU1BfSEVMUCBc
Ci0iICAgIFRoaXMgaXMgdXNlZCB0byBzcGVjaWZ5IHRoZSBob3N0IGRzcCBkZXZpY2UgdG8gdGhl
IGhvc3RhdWRpbyBkcml2ZXIuXG4iIFwKLSIgICAgVGhlIGRlZmF1bHQgaXMgXCIiIEhPU1RBVURJ
T19ERVZfRFNQICJcIi5cblxuIgotCiBfX3VtbF9zZXR1cCgiZHNwPSIsIHNldF9kc3AsICJkc3A9
PGRzcCBkZXZpY2U+XG4iIERTUF9IRUxQKTsKIAogc3RhdGljIGludCBzZXRfbWl4ZXIoY2hhciAq
bmFtZSwgaW50ICphZGQpCkBAIC0zOSwxMCArNDMsNiBAQAogCXJldHVybigwKTsKIH0KIAotI2Rl
ZmluZSBNSVhFUl9IRUxQIFwKLSIgICAgVGhpcyBpcyB1c2VkIHRvIHNwZWNpZnkgdGhlIGhvc3Qg
bWl4ZXIgZGV2aWNlIHRvIHRoZSBob3N0YXVkaW8gZHJpdmVyLlxuIiBcCi0iICAgIFRoZSBkZWZh
dWx0IGlzIFwiIiBIT1NUQVVESU9fREVWX01JWEVSICJcIi5cblxuIgotCiBfX3VtbF9zZXR1cCgi
bWl4ZXI9Iiwgc2V0X21peGVyLCAibWl4ZXI9PG1peGVyIGRldmljZT5cbiIgTUlYRVJfSEVMUCk7
CiAKICNlbHNlIC8qTU9EVUxFKi8K
----__JNP_000_348b.1d93.6b9a--


________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
