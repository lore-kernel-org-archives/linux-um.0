Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJuAQ-0003Dv-VM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 06:36:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJuAQ-0006SF-Ce for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 06:36:46 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Missing exported symbols?
References: <200410091057.52832.u3205097@anu.edu.au>
In-Reply-To: <200410091057.52832.u3205097@anu.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410191537.24470.blaisorblade_spam@yahoo.it>
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
Date: Tue, 19 Oct 2004 15:37:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James Roper <u3205097@anu.edu.au>

On Saturday 09 October 2004 02:57, James Roper wrote:
> I'm still using the 2.6.8 uml patch release, and I'm getting heaps of
> errors complaining about unknown symbols.  In particular:
> WARNING: ../mnt/ lib/modules/2.6.8-1um/kernel/fs/cifs/cifs.ko needs unknown
> symbol memmove
> Which I need as I'm doing cifs development.  I saw an incremental 2.6.9-rc2
> patch that said it added heaps of exported symbols, is there anything for
> 2.6.8?  Or is there a simple way to export the memmove symbol?

This patch also contains (at this moment) the needed export:

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.8.1-1um/patches/export

However, you could try the 2.6.9-rc2 kernel, or from 2.6.9-rc4-bk2 onwards. 
The patch, if needed, should apply as well, I guess (at least by hand). I 
think it was merged, however.

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
