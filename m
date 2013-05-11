Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ub8tj-0000sV-W1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 12:27:36 +0000
Received: from mail-we0-f182.google.com ([74.125.82.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub8tj-0003h0-7h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 12:27:35 +0000
Received: by mail-we0-f182.google.com with SMTP id t60so4819370wes.41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 05:27:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvz1OO4Zet_Yq1GCwDz4D2FKygs45-H4UY_fyJ-SZ5weXQ@mail.gmail.com>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
	<CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
	<518E14B7.3030409@gmx.de> <20130511140139.1e6ee40b@sf>
	<CAFLxGvz1OO4Zet_Yq1GCwDz4D2FKygs45-H4UY_fyJ-SZ5weXQ@mail.gmail.com>
Date: Sat, 11 May 2013 14:27:28 +0200
Message-ID: <CAFLxGvzPCs3-RC34yxbdDCJOC17nBuhiMQV49wH2zth2JYM0+Q@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=089e013d18d22dd0c204dc7068d6
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
	mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: Sergei Trofimovich <slyich@gmail.com>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Dave Jones <davej@redhat.com>

--089e013d18d22dd0c204dc7068d6
Content-Type: text/plain; charset=ISO-8859-1

On Sat, May 11, 2013 at 2:26 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Sat, May 11, 2013 at 1:01 PM, Sergei Trofimovich <slyich@gmail.com> wrote:
>>> With this change:
>>>
>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>> index 7b1ca9b..289211d 100644
>>> --- a/fs/namespace.c
>>> +++ b/fs/namespace.c
>>> @@ -2236,6 +2236,8 @@ int copy_mount_string(const void __user *data, char **where)
>>>                 return 0;
>>>         }
>>>
>>> +       printk(" here: size is %ul\n", (unsigned long)data);
>>
>> Be careful, it's long->int truncation. I guess you want '%lu' instead of '%ul'.
>
> Toralf, please use the attached patch.
> Maybe it helps us.
> In theory we call kmalloc() with at most PAGE_SIZE, which is okay.

fixing -ENOATTACHMENT...

--
Thanks,
//richard

--089e013d18d22dd0c204dc7068d6
Content-Type: application/octet-stream; name="debug.patch"
Content-Disposition: attachment; filename="debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hgkrqwq50

ZGlmZiAtLWdpdCBhL2ZzL25hbWVzcGFjZS5jIGIvZnMvbmFtZXNwYWNlLmMKaW5kZXggN2IxY2E5
Yi4uN2Y5YmY1OGEgMTAwNjQ0Ci0tLSBhL2ZzL25hbWVzcGFjZS5jCisrKyBiL2ZzL25hbWVzcGFj
ZS5jCkBAIC0yMjM2LDcgKzIyMzYsNyBAQCBpbnQgY29weV9tb3VudF9zdHJpbmcoY29uc3Qgdm9p
ZCBfX3VzZXIgKmRhdGEsIGNoYXIgKip3aGVyZSkKIAkJcmV0dXJuIDA7CiAJfQogCi0JdG1wID0g
c3RybmR1cF91c2VyKGRhdGEsIFBBR0VfU0laRSk7CisJdG1wID0gc3RybmR1cF91c2VyX2RlYnVn
KGRhdGEsIFBBR0VfU0laRSwgdHJ1ZSk7CiAJaWYgKElTX0VSUih0bXApKQogCQlyZXR1cm4gUFRS
X0VSUih0bXApOwogCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N0cmluZy5oIGIvaW5jbHVk
ZS9saW51eC9zdHJpbmcuaAppbmRleCBhYzg4OWM1Li4zYjk2MmI4IDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L3N0cmluZy5oCisrKyBiL2luY2x1ZGUvbGludXgvc3RyaW5nLmgKQEAgLTksNiAr
OSw3IEBACiAjaW5jbHVkZSA8dWFwaS9saW51eC9zdHJpbmcuaD4KIAogZXh0ZXJuIGNoYXIgKnN0
cm5kdXBfdXNlcihjb25zdCBjaGFyIF9fdXNlciAqLCBsb25nKTsKK2V4dGVybiBjaGFyICpzdHJu
ZHVwX3VzZXJfZGVidWcoY29uc3QgY2hhciBfX3VzZXIgKiwgbG9uZywgYm9vbCk7CiBleHRlcm4g
dm9pZCAqbWVtZHVwX3VzZXIoY29uc3Qgdm9pZCBfX3VzZXIgKiwgc2l6ZV90KTsKIAogLyoKZGlm
ZiAtLWdpdCBhL21tL3V0aWwuYyBiL21tL3V0aWwuYwppbmRleCBhYjE0MjRkLi5jOTViMDhjIDEw
MDY0NAotLS0gYS9tbS91dGlsLmMKKysrIGIvbW0vdXRpbC5jCkBAIC0yMDMsMTMgKzIwMywxNiBA
QCBFWFBPUlRfU1lNQk9MKGt6ZnJlZSk7CiAgKiBAczogVGhlIHN0cmluZyB0byBkdXBsaWNhdGUK
ICAqIEBuOiBNYXhpbXVtIG51bWJlciBvZiBieXRlcyB0byBjb3B5LCBpbmNsdWRpbmcgdGhlIHRy
YWlsaW5nIE5VTC4KICAqLwotY2hhciAqc3RybmR1cF91c2VyKGNvbnN0IGNoYXIgX191c2VyICpz
LCBsb25nIG4pCitjaGFyICpzdHJuZHVwX3VzZXJfZGVidWcoY29uc3QgY2hhciBfX3VzZXIgKnMs
IGxvbmcgbiwgYm9vbCBkZWJ1ZykKIHsKIAljaGFyICpwOwogCWxvbmcgbGVuZ3RoOwogCiAJbGVu
Z3RoID0gc3Rybmxlbl91c2VyKHMsIG4pOwogCisJaWYgKGRlYnVnKQorCQlwcmludGsoS0VSTl9F
UlIgIiVzOiBzdHJubGVuX3VzZXIoKSByZXR1cm5lZDogJWxpXG4iLCBfX2Z1bmNfXywgbGVuZ3Ro
KTsKKwogCWlmICghbGVuZ3RoKQogCQlyZXR1cm4gRVJSX1BUUigtRUZBVUxUKTsKIApAQCAtMjE4
LDYgKzIyMSw5IEBAIGNoYXIgKnN0cm5kdXBfdXNlcihjb25zdCBjaGFyIF9fdXNlciAqcywgbG9u
ZyBuKQogCiAJcCA9IG1lbWR1cF91c2VyKHMsIGxlbmd0aCk7CiAKKwlpZiAoZGVidWcpCisJCXBy
aW50ayhLRVJOX0VSUiAiJXM6IGNhbGxpbmcgbWVtZHVwX3VzZXIoKSB3aXRoIGxlbmd0aDogJWxp
XG4iLCBfX2Z1bmNfXywgbGVuZ3RoKTsKKwogCWlmIChJU19FUlIocCkpCiAJCXJldHVybiBwOwog
CkBAIC0yMjUsNiArMjMxLDEyIEBAIGNoYXIgKnN0cm5kdXBfdXNlcihjb25zdCBjaGFyIF9fdXNl
ciAqcywgbG9uZyBuKQogCiAJcmV0dXJuIHA7CiB9CitFWFBPUlRfU1lNQk9MKHN0cm5kdXBfdXNl
cl9kZWJ1Zyk7CisKK2NoYXIgKnN0cm5kdXBfdXNlcihjb25zdCBjaGFyIF9fdXNlciAqcywgbG9u
ZyBuKQoreworCXJldHVybiBzdHJuZHVwX3VzZXJfZGVidWcocywgbiwgZmFsc2UpOworfQogRVhQ
T1JUX1NZTUJPTChzdHJuZHVwX3VzZXIpOwogCiB2b2lkIF9fdm1hX2xpbmtfbGlzdChzdHJ1Y3Qg
bW1fc3RydWN0ICptbSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCg==
--089e013d18d22dd0c204dc7068d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--089e013d18d22dd0c204dc7068d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--089e013d18d22dd0c204dc7068d6--


