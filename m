Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJZ97-0001CX-Bp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 08:10:01 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CJZ96-00062Z-AK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 08:10:01 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch 1/1] SKAS3: fix mm->dumpable handling
References: <20041014161758.C4CF444BE@zion.localdomain>
In-Reply-To: <20041014161758.C4CF444BE@zion.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410161708.27369.blaisorblade_spam@yahoo.it>
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
Date: Sat, 16 Oct 2004 17:08:26 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, uml@hno.marasystems.com, mcr@sandelman.ottawa.on.ca

On Thursday 14 October 2004 18:17, blaisorblade_spam@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Henrik
> Nordstrom <uml@hno.marasystems.com>, Michael Richardson
> <mcr@sandelman.ottawa.on.ca>

> When a child mm is created by opening /proc/mm, without this patch its
> mm->dumpable flag is left set to 0, even when there is no reason to do so.
>
> This way, for instance, if <pid> is the pid of a userspace thread,
> /proc/<pid> is only readable by root (which was the original reason letting
> this be diagnosed by Michael Richardson).

> Paolo and Henrik discussed about this in detail, finally Paolo wrote the
> patch and sent it for comment.
And Paolo (myself) fucked it up:

> +		/* Let's be safe. If we are ptraced from a non-dumpable process,
> +		 * let's not be dumpable. Don't try to be smart and turn
> +		 * current->dumpable to 1: it may be unsafe.*/
> +		if (!current->dumpable) {
This should be current->mm->dumpable, not current->dumpable.
> +			new->dumpable = 0;
> +			wmb();
> +		}
> +
>  		atomic_inc(&new->mm_users);
>  		child->mm = new;
>  		child->active_mm = new;
> _
Also, we have not studied the case of another process trying to ptrace and 
SWITCH_MM a process already having some mm's (it cannot give it any already 
existing mm, because it has not the file descriptor). It seems safe to me, 
but I'm going to study this and put the result in next patch version.
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
