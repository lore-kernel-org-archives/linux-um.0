Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWR3e-0000BV-TF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 19:09:34 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CWR3d-0000vs-R8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 19:09:34 -0800
Message-ID: <41A2A9E3.9070203@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [patch 3/4] uml: remove most devfs_mk_symlink
	calls
References: <20041119011337.74CDD7B9C9@zion.localdomain>
	<87sm726j2h.fsf@aka.i.naked.iki.fi>
	<200411222325.17269.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411222325.17269.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 23 Nov 2004 16:09:23 +1300
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

How will this affect existing UML setups?  Does it mean they would need 
to change if we started them up with a new UML kernel after /dev/ubd/0 
"goes away"?  That would mean quite a disruption to operations (i.e. 
making changes on lots of UML instances).  Is there a way to acheive 
what you're doing in a backwards-compatible manner?

Regards, Peter

Blaisorblade wrote:
> I'd suggest to also stop using /dev/ubd/0 symlinks and going directly 
> to /dev/ubd/disc.../disc (whatever), since the first one could soon go away 
> (I've deferred that at least for now).
> 
> Bye


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
