Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CH9rh-0003vE-ED for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 16:46:05 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CH9rW-0001IO-AA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 16:46:05 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Default kernel configuration on 2.6.x
References: <416B07AC.3030308@sektor37.de>
In-Reply-To: <416B07AC.3030308@sektor37.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410120146.06254.blaisorblade_spam@yahoo.it>
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
Date: Tue, 12 Oct 2004 01:46:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Julian Scheid <julian@sektor37.de>, jdike@karaya.com

On Tuesday 12 October 2004 00:22, Julian Scheid wrote:

> This is especially fatal because without a virtual character device
> driver, stdio initialization will fail silently or with an unhelpful
> error message ("sleeping process got unexpected signal 11"), leaving
> unsuspecting users like me completely puzzled.
I.e. that error comes from this?????? Thanks a lot for this solution, but 
could you explain which is exactly the wrong CONFIG_ option set for this to 
happen?

> Therefore I think it would make sense to have the UML patches for the
> affected kernel versions remove the second through fourth element from
> conf_confnames (as shown above) so that the build will immediately fall
> back to arch/um/defconfig if .config isn't found, always ignoring status
> quo configuration files on the host. A corresponding patch for 2.6.8.1
> is attached.

[Please always avoid sending that kind of patches; you **MUST ALWAYS** use 
unified diffs, i.e. diff -u; the preferred setting is -puNr].
> Perhaps a note should be added somewhere pointing out the non-standard
> behavior to avoid confusing seasoned kernel recompilers, but I'm not
> sure where to put it. I'll leave that to the maintainers should you
> agree with the patch.
About this, see the other responses - this must be done in mainline whenever 
we are cross-compiling.

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
