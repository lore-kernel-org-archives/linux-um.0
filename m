Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEuPm-0002CC-US for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:51:58 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEuPl-0008IY-OC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:51:58 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] T-mode processes
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<200410042057.19226.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.61.0410042223180.483@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0410042223180.483@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052051.47614.blaisorblade_spam@yahoo.it>
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
Date: Tue, 5 Oct 2004 20:51:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Monday 04 October 2004 22:25, Henrik Nordstrom wrote:
> On Mon, 4 Oct 2004, BlaisorBlade wrote:
> > Actually, what I should do is to set the "mm->dumpable" flag to 1 inside
> > mm/proc_mm.c (after mm_alloc(), it is 0). The situation is clear.
> > However, to write a good patch, I want to study well the "mm->dumpable"
> > flag use (when it's set, when not...) otherwise I could open a security
> > hole (even because there are people using UML setuid to root, for the
> > mlock() patch).
>
> I don't think it is safe to set dumpable to 1 once it has become 0.

I think you are overlooking something ... read the original mail. The problem 
is that for the userspace thread mm->dumpable is always 0, and this happens 
on every known SKAS3 patch revision. Simply nobody thought about this before 
now.

The field does not "become" 0. allocate_mm, or whatever, allocates the 
mm_struct, fills it with 0, and then initializes some basic fields. After 
fork and execve, the dumpable field is adjusted according to the needs (and 
can become 1).

Since opening /proc/mm is more or less like creating a new process (or even 
like forking), dumpable can become 1, following the general Linux rules. 

Actually, the current fork() code simply copies the dumpable flag with all the 
rest, and does not change it; this also makes a lot of sense, and I guess 
that open_proc_mm will just copy the current->mm->dumpable setting to the new 
mm.

However, that's a problem if a process using /proc/mm changes its setting of 
mm->dumpable (which happens on uid changes and with prctl). Does in that case 
the uid of the ptraced process change?

If needed, it could be reloaded on the new mm when using PROC_SWITCH_MM, but 
that is strange. Also, I don't understand why prctl() does not do any 
security check.

And anyway, I'm not rushing on this... I want to study the mainstream code and 
the ptrace exploit patch, before coding anything here.

> If you want to fix this you need to find secure ways to prevent it from
> becoming 0, or to add another parameter defining "security restricted"
> processes differently from dumpable.

Hmm, Alan Cox has been writing some changes to the dumpable flag (a sysctl 
option, I think).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
