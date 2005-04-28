Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRJgJ-0000CH-8B	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:48:35 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DRJgI-0002og-Mq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:48:35 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Hostfs permission checks are all wonky.
References: <200503201417.59739.rob@landley.net>
	<200503281448.22110.rob@landley.net>
	<200504292253.45547.blaisorblade@yahoo.it>
In-Reply-To: <200504292253.45547.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504281945.29259.rob@landley.net>
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
Date: Thu, 28 Apr 2005 19:45:29 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 29 April 2005 04:53 pm, Blaisorblade wrote:
> While doing other stuff, I've understood how UML reaches that code:
>
> hostfs_read_sb->get_sb_nodev->set_anon_super()->idr_XXX. However, I can't
> understand why the hell UML could have bugs in this path. Probably running
> it with a root hostfs will trigger this, but for now I haven't the time to
> play with this.

I have a vague recollection that running UML not just with a root hostfs but 
as the root user on the host made the problem more likely to occur.  (Don't 
know if that's actually necessary to reproduce or not, and don't have free 
space on my laptop to compile up a copy just now...)

> Also, I've seen somebody else with a "idr" problem, related to devpts
> (recent posts, titled "ssh again" IIRC). Still I don't understand what's
> going on.

Rob


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
