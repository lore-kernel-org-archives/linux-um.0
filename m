Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BC03U-0004P5-6r for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 10:44:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BC03T-0007ey-K5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 10:44:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <40686E7D.2080600@unclewebster.com>
	<200404011953.43255.blaisorblade_spam@yahoo.it>
	<200404051840.i35IeHhZ029055@ccure.user-mode-linux.org>
In-Reply-To: <200404051840.i35IeHhZ029055@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404091954.54804.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Hostfs and Humfs
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
Date: Fri, 9 Apr 2004 19:54:54 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 20:40, luned=EC 5 aprile 2004, hai scritto:
> BTW, if you do IRC, you will have a better idea of what exactly I'm doing
> if you hang on the UML IRC channel - #uml on oftc.net.  I'm there quite
> often, and I tend to mumble about what I'm working on at the moment.
>
> Also, would you be interested in being able to put downloads on the UML
> site rather than having them on user-linux-linux.org, which isn't as
> visible?

Sorry for answering so late, but I've been away for a week, for theoretical=
=20
studies in computer science. For now I must decrease my UML activity since =

I'll have to solve a very hard test soon; and I cannot do that myself.

However, especially for the second question, the answer is "yes".

At least for the 2.4.25 and 2.6.4 Skas patches, which are VERY important fo=
r=20
users. Especially because there are 3 bugs in most SKAS patches floating=20
around:
- the SMP bug we discussed about some time ago, fixed in my last release;
- this change (the one in the 2nd one) from Ingo Molnar that everyone else =

missed:

-static int write_ldt(void __user * ptr, unsigned long bytecount, int oldmo=
de)
+static int write_ldt(struct mm_struct * mm, void __user * ptr, unsigned lo=
ng=20
bytecount, int oldmode)
 {
-       struct mm_struct * mm =3D current->mm;
        __u32 entry_1, entry_2, *lp;
        int error;
        struct user_desc ldt_info;
@@ -195,7 +197,7 @@

        down(&mm->context.sem);
        if (ldt_info.entry_number >=3D mm->context.size) {
///// ---------------> NO ONE NOTICED this!
-               error =3D alloc_ldt(&current->mm->context, =20
ldt_info.entry_number+1, 1);
+               error =3D alloc_ldt(&mm->context, ldt_info.entry_number+1, =
1);
                if (error < 0)
                        goto out_unlock;
        }

- and finally this bug he fixed in  ldt.c

-       if (reload) {
+       if (reload && (&current->active_mm->context =3D=3D pc)) {


They are perfectly, with only one issue: since there is CONFIG_PROC_MM in t=
he=20
headers, which is created by make oldconfig, but you don't have a=20
user-visible option, user often miscompile the kernel (which then creates a=
=20
"Checking for Skas3 patch ... yes Checking for /proc/mm ... no").

Also, I see no reason for which the bug with switch_mm() that involved the =

Skas patch in 2.6 should not happen also in 2.4; in 2.4.25 we have this=20
check, which has never been triggered (include/asm-i386/mmu_context.h):

                if(cpu_tlbstate[cpu].active_mm !=3D next)
                        out_of_line_bug();

So, maybe the 2.4 Skas patch could need the same change the 2.6 has in=20
include/asm-i386/mmu_context.h.

However, please review and upload them by yourself. I'm actually busy at th=
e=20
moment - VERY busy.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
