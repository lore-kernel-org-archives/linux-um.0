Return-Path: <agnel.joel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1847021.mDh9H4lbpW@blindfold>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
 <CAMuHMdU0jYx+NdZWdZpSwWZkBNvBDJ14trvM8B49h4st_7RkgA@mail.gmail.com> <1847021.mDh9H4lbpW@blindfold>
From: Joel Fernandes <agnel.joel@gmail.com>
Date: Wed, 28 Mar 2018 15:19:39 -0700
Message-ID: <CAD=GYpaBOgoWGW3F5kjk_0V8mUw1VeWLm7PnveNGejfehoE1Og@mail.gmail.com>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
Content-Type: multipart/mixed; boundary="0000000000003abed405688067ca"
To: Richard Weinberger <richard@nod.at>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

--0000000000003abed405688067ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick reply.

On Wed, Mar 28, 2018 at 6:19 AM, Richard Weinberger <richard@nod.at> wrote:
> Am Mittwoch, 28. M=C3=A4rz 2018, 15:11:29 CEST schrieb Geert Uytterhoeven=
:
>> On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.com>
> wrote:
>> >         while(release_now =3D=3D 0);
>>
>> while (release_now =3D=3D 0)
>>         cpu_relax();
>
> Not sure whether a cpu_relax() fixes the problem.
> I guess the root of the problem is that UML is UP and non-preemptive.
> Therefore the loop is never interrupted.
> To verify I asked for the full source.
>

cpu_relax actually worked!

Any thoughts on why it helps? Even if its non-preemptive, I did
receive the timer interrupt, so I expected the variable to be set.

Module is attached.

Thanks,
-Joel

--0000000000003abed405688067ca
Content-Type: text/x-csrc; charset="US-ASCII"; name="ldtest1.c"
Content-Disposition: attachment; filename="ldtest1.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfbnkg4p0

LyoKICogVGhpcyBtb2R1bGUgZW1pdHMgIkhlbGxvLCB3b3JsZCIgb24gcHJpbnRrIHdoZW4gbG9h
ZGVkLgogKgogKiBJdCBpcyBkZXNpZ25lZCB0byBiZSB1c2VkIGZvciBiYXNpYyBldmFsdWF0aW9u
IG9mIHRoZSBtb2R1bGUgbG9hZGluZwogKiBzdWJzeXN0ZW0gKGZvciBleGFtcGxlIHdoZW4gdmFs
aWRhdGluZyBtb2R1bGUgc2lnbmluZy92ZXJpZmljYXRpb24pLiBJdAogKiBsYWNrcyBhbnkgZXh0
cmEgZGVwZW5kZW5jaWVzLCBhbmQgd2lsbCBub3Qgbm9ybWFsbHkgYmUgbG9hZGVkIGJ5IHRoZQog
KiBzeXN0ZW0gdW5sZXNzIGV4cGxpY2l0bHkgcmVxdWVzdGVkIGJ5IG5hbWUuCiAqLwoKI2RlZmlu
ZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFNRSAiOiAiIGZtdAoKI2luY2x1ZGUgPGxpbnV4L2lu
aXQuaD4KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8bGludXgvcHJpbnRrLmg+
CiNpbmNsdWRlIDxsaW51eC9yYXRlbGltaXQuaD4KI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CiNp
bmNsdWRlIDxsaW51eC9zY2hlZC5oPgoKc3RydWN0IGJpZ3N0ciB7CglzcGlubG9ja190IGJpZ2xv
Y2s7Cn07CgpzdHJ1Y3QgYmlnc3RyICppbDsKc3RydWN0IGhydGltZXIgYmlndGltZXI7CmludCBy
ZWxlYXNlX25vdzsKCnN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydCBiaWd0aW1lcl9oYW5kbGUo
c3RydWN0IGhydGltZXIgKnRpbWVyKQp7CglwcmludGsoS0VSTl9FUlIgInRpbWVyIGZpcmVkIDJc
biIpOwoJc3Bpbl9sb2NrKCZpbC0+YmlnbG9jayk7CglzcGluX3VubG9jaygmaWwtPmJpZ2xvY2sp
OwoKCXJlbGVhc2Vfbm93ID0gMTsKCglyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7Cn0KCnZvaWQg
aW5pdF9iaWdzdHIoc3RydWN0IGJpZ3N0ciAqYikKewoJc3Bpbl9sb2NrX2luaXQoJmItPmJpZ2xv
Y2spOwp9CgpzdGF0aWMgaW50IF9faW5pdCB0ZXN0X21vZHVsZV9pbml0KHZvaWQpCnsKCXN0cnVj
dCBiaWdzdHIgYjEsIGIyOwoJc3RydWN0IGhydGltZXIgKnRpbWVyOwoKCXJlbGVhc2Vfbm93ID0g
MDsKCglpbml0X2JpZ3N0cigmYjEpOwoJaW5pdF9iaWdzdHIoJmIyKTsKCgl0aW1lciA9ICZiaWd0
aW1lcjsKCXRpbWVyLT5kZWJ1ZyA9IDE7CgoJaHJ0aW1lcl9pbml0KHRpbWVyLCBDTE9DS19NT05P
VE9OSUMsIEhSVElNRVJfTU9ERV9SRUwpOwoJdGltZXItPmZ1bmN0aW9uID0gYmlndGltZXJfaGFu
ZGxlOwoKCWlsID0gJmIyOwoJc3Bpbl9sb2NrKCZiMS5iaWdsb2NrKTsKCglwcmludGsoS0VSTl9F
UlIgIlN0YXJ0aW5nIHRpbWVyXG4iKTsKCWhydGltZXJfc3RhcnQodGltZXIsIG5zX3RvX2t0aW1l
KDUwMDAwVUxMKSwKCQkgICAgICBIUlRJTUVSX01PREVfUkVMX1BJTk5FRCk7CgoJd2hpbGUocmVs
ZWFzZV9ub3cgPT0gMCkKCQljcHVfcmVsYXgoKTsKCglzcGluX3VubG9jaygmYjEuYmlnbG9jayk7
CglyZXR1cm4gLTE7Cn0KCm1vZHVsZV9pbml0KHRlc3RfbW9kdWxlX2luaXQpOwoKc3RhdGljIHZv
aWQgX19leGl0IHRlc3RfbW9kdWxlX2V4aXQodm9pZCkKewp9Cgptb2R1bGVfZXhpdCh0ZXN0X21v
ZHVsZV9leGl0KTsKCk1PRFVMRV9BVVRIT1IoIkpvZWwgRmVybmFuZGVzIDxhZ25lbC5qb2VsQGdt
YWlsLmNvbT4iKTsKTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwo=
--0000000000003abed405688067ca--

