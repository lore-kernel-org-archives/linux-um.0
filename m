Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D990p-0003IZ-0Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 13:46:39 -0800
Received: from rproxy.gmail.com ([64.233.170.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D990l-00086g-JE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 13:46:38 -0800
Received: by rproxy.gmail.com with SMTP id z35so526346rne
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 09 Mar 2005 13:46:34 -0800 (PST)
Message-ID: <3524bf1f050309134652547bf@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] tun/tap network throughput problem
In-Reply-To: <200503092029.30119.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
	<200503092029.30119.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 16:46:34 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

sure, allow me to check if everything looks fine (at least) to me...


On Wed, 9 Mar 2005 20:29:29 +0100, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Monday 07 March 2005 21:56, Young Koh wrote:
> > Hi,
> >
> > i was running an expriment to measure network throughput of UML.
> > physical machine A and B are connected with gigabit network. and UML
> > runs on machine A. i'm sending bulk UDP packets from UML to machine B
> > using ttcp network throughput benchmark program.
> > i'm using 2.4.26 for both UML and host. (skas + sysemu patched)
> >
> > i modified UML kernel code to get high performance a little bit, and i
> > got some gain with TCP and UDP throughput.
> Hmm, can you share your changes with us, please? We'd be very grateful...
> --
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
> http://www.user-mode-linux.org/~blaisorblade
> 
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
