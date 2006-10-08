Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWepg-00042e-8I for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 13:01:08 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GWepf-0004NF-Kg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 13:01:08 -0700
Message-ID: <452958FD.3020400@linuxbox.cz>
Date: Sun, 08 Oct 2006 23:01:01 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>	<200610081304.39570.blaisorblade@yahoo.it>	<45294CBD.2010602@linuxbox.cz>
	<200610082130.52498.blaisorblade@yahoo.it>
In-Reply-To: <200610082130.52498.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

That's it!
-mm3 kernel is causing this problem, and Your patch indeed fixes it! I 
completely forgot that I was also trying mm patches and I certainly 
mixed them with Your patches :-/
at least I'm glad that I now know where the problem was...

Blaisorblade wrote:
> On Sunday 08 October 2006 21:08, Nikola Ciprich wrote:
>   
>> Hello Paolo,
>> I've spent half a day today trying all variants, and well, I'm no longer
>> able to reproduce the problem :(
>> In fact now APPLYING your patch seems to cause the problem, which is of
>> course weird.
>>     
> The patch will cause the problem if applied without another certain patch, so 
> it means that 2.6.18-mm2 does not contain it. I can't be sure without the 
> compilation error but I can guess it is the problem.
>
>   
>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
