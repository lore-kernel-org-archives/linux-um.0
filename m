Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CGJjU-00023n-CH for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 09:06:08 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CGJjS-0007da-0s for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 09:06:08 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] segv soon after startup 2.6.9-rc2-mm4
References: <EAC7622167479948B614F8B9AD41C505ECA5D4@MAANDMBX2.ets.enterasys.com>
In-Reply-To: <EAC7622167479948B614F8B9AD41C505ECA5D4@MAANDMBX2.ets.enterasys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410091806.12662.blaisorblade_spam@yahoo.it>
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
Date: Sat, 9 Oct 2004 18:06:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>

On Wednesday 06 October 2004 14:49, Tsillas, Demetrios J wrote:
> Using 2.6.9-rc2-mm4 with the incrementals.
>
> If CONFIG_MODE_TT is enabled and linux is run with
> no args. The value of argv[1] is 0 causing a crash
> with strlen in linux_main:
>
> 349     #ifdef CONFIG_MODE_TT
> 350             argv1_begin = argv[1];
> 351             argv1_end = &argv[1][strlen(argv[1])];
> 352     #endif
False. Running linux with no args causes it complaining because you did not 
say him which root fs to use:

VFS: Cannot open root device "98:0" or unknown-block(98,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(98,0)

Also, more important, argv[1] is 0 and in that case strlen(argv[1]) will be 0, 
so argv1_end will be equal to argv1_begin. Since argv1_end is a pointer at 
the first byte out of argv[1], then we are safe. For instance:

void set_cmdline(char *cmd)
{
#ifdef CONFIG_MODE_TT
        char *umid, *ptr;

        if(CHOOSE_MODE(honeypot, 0)) return;

        umid = get_umid(1);
        if(umid != NULL){
                snprintf(argv1_begin,
                         (argv1_end - argv1_begin) * sizeof(*ptr),
                         "(%s) ", umid);
                ptr = &argv1_begin[strlen(argv1_begin)];
        }
        else ptr = argv1_begin;

        snprintf(ptr, (argv1_end - ptr) * sizeof(*ptr), "[%s]", cmd);
        memset(argv1_begin + strlen(argv1_begin), '\0',
               argv1_end - argv1_begin - strlen(argv1_begin));
#endif
}

> BTW, I've had problems building with CONFIG_MODE_TT
> turned off:
I'm going to try myself and fix the problems.
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
