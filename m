Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<008901c44c40$c2ed0e30$dd02a8c0@ferraro>
	<878yerf7d4.fsf@amaterasu.srvr.nix>
	<200406142109.45156.blaisorblade_spam@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200406142109.45156.blaisorblade_spam@yahoo.it> (BlaisorBlade's
	message of "Mon, 14 Jun 2004 21:09:45 +0200")
Message-ID: <87oenle40x.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 15 Jun 2004 07:20:14 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: uml <uml@dot1q.net>, roland <for_spam@gmx.de>, uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 14 Jun 2004, BlaisorBlade mused:
> Alle 23:58, domenica 13 giugno 2004, Nix ha scritto:
>> On Sun, 06 Jun 2004, uml@dot1q.net stipulated:
>> > Switch differences between -O1 and -O2 on GCC 3.3.3:
>>
>> Note: -O{n} are *not* the equivalent of groups of -f switches:
>> they turn those switches on, but other things inside the compiler
>> are directly triggered by the optimization level.
> 
> I expected that SuSE 9.1 shipped a buggy gcc, but I didn't found any confirm 
> to this (I remember they did such things in the past). However the fact that 
> the compiler output that dump is anyway a compiler bug...

Oh, yes, certainly.

> Well, ok, more hints, the first possible answer to this one seems to be that 
> SuSE enables -funit-at-a-time:

(unsurprising, given that -funit-at-a-time's primary author is jh@suse ;} )

> http://www.google.com/search?q=%22SuSE+9.1%22+bug+gcc&sourceid=opera&num=25&ie=utf-8&oe=utf-8
> 
> I checked the first hit (read the whole thread):
> 
> http://gcc.gnu.org/ml/gcc-bugs/2004-05/msg01912.html

Yep, -funit-at-a-time will definitely break kernels that aren't
expecting it, both because of elision of unused statics and because some
arches depend on emission of asm's at the top level to emit stuff in the
same order in generated code, and with -funit-at-a-time this just
doesn't happen anymore. (I don't think i386 is such an architecture,
though.)

-funit-at-a-time is enabled by default for C and C++ in GCC 3.4.

> This is the trick:
> "#define ATTRIBUTE_USED
> #if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >=4)
> #undef ATTRIBUTE_USED
> #define ATTRIBUTE_USED __attribute__((used))
> #endif

The sort of thing you want to stash away in a header file and never lay
eyes on again. :)

> static const int hello ATTRIBUTE_USED  = 56;
> 
> int main()
> {
>         asm(
>         "mov hello, %eax\n"
>         );

Well, in this *specific* case, hello should be marked as clobbered,
which will also stop the compiler eliding it. But this *was* a contrived
testcase...

-- 
`We in no way believe that this Christ was a space alien.'
                    --- A creationist website goes completely bonkers


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
