Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba4yZ-0002er-Vy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:51:07 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ba4yZ-0001S9-Er for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 20:51:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<008901c44c40$c2ed0e30$dd02a8c0@ferraro>
	<878yerf7d4.fsf@amaterasu.srvr.nix>
In-Reply-To: <878yerf7d4.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406142109.45156.blaisorblade_spam@yahoo.it>
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
Date: Mon, 14 Jun 2004 21:09:45 +0200
To: Nix <nix@esperi.org.uk>, uml <uml@dot1q.net>, roland <for_spam@gmx.de>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

Alle 23:58, domenica 13 giugno 2004, Nix ha scritto:
> On Sun, 06 Jun 2004, uml@dot1q.net stipulated:
> > Switch differences between -O1 and -O2 on GCC 3.3.3:
>
> Note: -O{n} are *not* the equivalent of groups of -f switches:
> they turn those switches on, but other things inside the compiler
> are directly triggered by the optimization level.

I expected that SuSE 9.1 shipped a buggy gcc, but I didn't found any confirm 
to this (I remember they did such things in the past). However the fact that 
the compiler output that dump is anyway a compiler bug...

Well, ok, more hints, the first possible answer to this one seems to be that 
SuSE enables -funit-at-a-time:

http://www.google.com/search?q=%22SuSE+9.1%22+bug+gcc&sourceid=opera&num=25&ie=utf-8&oe=utf-8

I checked the first hit (read the whole thread):

http://gcc.gnu.org/ml/gcc-bugs/2004-05/msg01912.html

And this is interesting enough:

(they indeed speak about SuSE 9.1)

"This is a dup of bug 14911, well it looks like *SUSE turns on 
-funit-at-a-time at -O2 for their 3.3.3*, so 
using the same method as mentioned in the other bug except change the 
"__GNUC_MINOR__ >=4" to 
be "__GNUC_MINOR__ >= 3" and it will work."

Here is bug 14911:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=14911

This is the trick:
"#define ATTRIBUTE_USED
#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >=4)
#undef ATTRIBUTE_USED
#define ATTRIBUTE_USED __attribute__((used))
#endif
static const int hello ATTRIBUTE_USED  = 56;
int main()
{
        asm(
        "mov hello, %eax\n"
        );
        return 0;
}"
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
