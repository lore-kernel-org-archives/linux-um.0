Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AT2IH-0004dE-9W
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 09:02:05 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AT2IG-0004Fp-JK
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 09:02:04 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] make clean & distclean are not cleaning up
In-Reply-To: <20031207.071354.-1654081.1.mcmechanjw@juno.com>
Message-ID: <Pine.LNX.4.44.0312071801310.31202-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 7 Dec 2003 18:01:51 +0100 (CET)
To: James W McMechan <mcmechanjw@juno.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Did you remember to specify the arch when you ran make clean?

Regards
Henrik

On Sat, 6 Dec 2003, James W McMechan wrote:

> It is looking like make clean & make distclean don't clear some          
>       
> of the headers :(                                                        
>       
> I had a config with TT off and then turned it on then I got a            
>       
> undefined TASK_EXTERN_PID for tt/gdb.c so I did a make clean,            
>       
> still no luck, make distclean alas did not clear the problem,            
>       
> so I just generated a new symlink tree to compile in, but I was          
>       
> startled that distclean did not clear out the configuration.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
