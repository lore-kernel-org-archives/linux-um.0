Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEzF3-0005SV-GT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 17:01:13 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEzF2-0003b1-7k for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 17:01:13 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] T-mode processes
In-Reply-To: <200410052051.47614.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.61.0410060141120.1986@filer.marasystems.com>
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<200410042057.19226.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.61.0410042223180.483@filer.marasystems.com>
	<200410052051.47614.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Wed, 6 Oct 2004 02:00:35 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Henrik Nordstrom <uml@hno.marasystems.com>, Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Tue, 5 Oct 2004, BlaisorBlade wrote:

> Since opening /proc/mm is more or less like creating a new process (or even
> like forking), dumpable can become 1, following the general Linux rules.

only if it was 1 for the process I think. If it was 0 for the process then 
there is a obvious risk that sensitive pages will get migrated to the new 
mm.

creating a new memory map within the process is not really the same as 
exec if I understand SKAS correctly. The two memory maps may be set to 
share a significant portion of pages including data pages, while on exec 
you are guaranteed the two memory maps are fully separate unless they 
cooperate via mmap or shm which both have access to.

If there is need to then it may be possible to add an argument indicating 
that the mm should be dumpable even if sanity checks says it should not, 
but I don't see very much need for this.

> However, that's a problem if a process using /proc/mm changes its 
> setting of mm->dumpable (which happens on uid changes and with prctl). 
> Does in that case the uid of the ptraced process change?

In such case the dumpable attribute needs to be cleared on all mm:s of 
that process. There is no easy way telling which memory maps may contain 
restricted pages on such change of the process status.

Regarding prctl, the running code can be assumed trusted here. The 
dumpable attribute is about preventing sensitive data from leaking outside 
of the process. If you circumvent this by setting dumpable to 1 you are 
assumed to know what you (and any libraries you use) do and assume all 
responsibility. It is only the running process code itself which can do 
this, the user can not force it externally from outside of the process

Regards
Henrik


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
