Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFHit-0001al-1h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 12:45:15 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CFHio-000410-Ca for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 12:45:14 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] T-mode processes
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<200410052051.47614.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.61.0410060141120.1986@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0410060141120.1986@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410062145.03109.blaisorblade_spam@yahoo.it>
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
Date: Wed, 6 Oct 2004 21:45:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Wednesday 06 October 2004 02:00, Henrik Nordstrom wrote:
> On Tue, 5 Oct 2004, BlaisorBlade wrote:
> > Since opening /proc/mm is more or less like creating a new process (or
> > even like forking), dumpable can become 1, following the general Linux
> > rules.
>
> only if it was 1 for the process I think. If it was 0 for the process then
> there is a obvious risk that sensitive pages will get migrated to the new
> mm.
Yes, I agree on this (even if I had not the "shared pages" problem in my 
picture of the problem).

> creating a new memory map within the process is not really the same as
> exec if I understand SKAS correctly. The two memory maps may be set to
> share a significant portion of pages including data pages, while on exec
> you are guaranteed the two memory maps are fully separate unless they
> cooperate via mmap or shm which both have access to.

In fact I was going to compare it to fork, not to exec, because what we do is 
more similar to creating a new mm and a new process, instead of replacing a 
process with another... and plus there is a lot of shared-memory, which is a 
problem.

> If there is need to then it may be possible to add an argument indicating
> that the mm should be dumpable even if sanity checks says it should not,
> but I don't see very much need for this.

I don't want to skip the sanity checks! They are currently skipped and 
dumpable is always 0. Stop. And the fact that we are safe (i.e. that dumpable 
is by default 0) seems to just be by a lucky accident, actually. Oh well.

> > However, that's a problem if a process using /proc/mm changes its
> > setting of mm->dumpable (which happens on uid changes and with prctl).
> > Does in that case the uid of the ptraced process change?

> In such case the dumpable attribute needs to be cleared on all mm:s of
> that process. There is no easy way telling which memory maps may contain
> restricted pages on such change of the process status.

Ok, in this case, this should be doable on PTRACE_SWITCH_MM. Anyway, the 
dumpable flag can become 1 again only with prctl(), so in that case things 
should be safe (or it is the application's fault).

> Regarding prctl, the running code can be assumed trusted here. The
> dumpable attribute is about preventing sensitive data from leaking outside
> of the process. If you circumvent this by setting dumpable to 1 you are
> assumed to know what you (and any libraries you use) do and assume all
> responsibility. It is only the running process code itself which can do
> this, the user can not force it externally from outside of the process

Ok, this is fine and clear.

Btw: I've also found the ptrace root exploit for 2.4.20. And I'm understanding 
the old problem.

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
