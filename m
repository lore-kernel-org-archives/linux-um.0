Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEY4A-0008Mo-Cb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 12:00:10 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEY3v-0003GR-CZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 12:00:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] T-mode processes
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<200410031704.29051.blaisorblade_spam@yahoo.it>
	<29485.1096825447@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <29485.1096825447@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410042057.19226.blaisorblade_spam@yahoo.it>
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
Date: Mon, 4 Oct 2004 20:57:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Sunday 03 October 2004 19:44, Michael Richardson wrote:
> >>>>> "BlaisorBlade" == BlaisorBlade  <blaisorblade_spam@yahoo.it> writes:
>     >> We also continue to have an issue with the /proc/PID/environ file
>     >> not being owned by the process involved.
>
>     BlaisorBlade> I'm looking at the permission in your listing and in
>     BlaisorBlade> my linux, and I don't see anything strange. Plus, I
>     BlaisorBlade> don't understand what you mean with "a file owned by a
>     BlaisorBlade> certain process".
>
>     BlaisorBlade> Do you mean "I start the process with uid build and
>     BlaisorBlade> /proc/PID/* has uid root while it should have uid
>     BlaisorBlade> build"?
>
>   Yes.
>
>     BlaisorBlade> If you mean this, the answer is that you seem to be
>     BlaisorBlade> starting UML with one id and making it run with
>     BlaisorBlade> another UID. At least, I see this permission situation
>     BlaisorBlade> with the X Font Server:

>   No, this is not the case.
>   It runs as "build" and that is all.

>   The problem is that the use of mm confuses the proc-permission system
> into thinking that the process is setuid. I wandered through this last
> year, when we first noticed this problem.

>   This seems to be due to how mm->dumpable is initalized.
> (see task_dumpable in fs/proc/base.c)
>   I tried to change it, but I was not successful. I can dig up my
> attempts, but they are on the list.

Oh, ok... this can be fixed, I guess, with these infos... I'll come back to 
this when I have time.

Actually, what I should do is to set the "mm->dumpable" flag to 1 inside 
mm/proc_mm.c (after mm_alloc(), it is 0). The situation is clear. However, to 
write a good patch, I want to study well the "mm->dumpable" flag use (when 
it's set, when not...) otherwise I could open a security hole (even because 
there are people using UML setuid to root, for the mlock() patch).

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
