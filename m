Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7jTj-0008Ib-BP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 16:46:23 -0700
Received: from mail.britsys.net ([216.183.103.29] helo=mail02.WWW.BRITSYS.NET)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7jTh-0004ue-Lm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 16:46:23 -0700
Message-ID: <4148D441.3030705@britsys.net>
From: David Jeffery <djeffery@britsys.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] set_thread_area and get_thread_area
References: <091520041520.7491.41485DA2000A997400001D4322007358340408979D9D0E04@comcast.net>
In-Reply-To: <091520041520.7491.41485DA2000A997400001D4322007358340408979D9D0E04@comcast.net>
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
Date: Wed, 15 Sep 2004 19:46:09 -0400
To: larryhl@comcast.net
Cc: user-mode-linux-devel@lists.sourceforge.net

larryhl@comcast.net wrote:

> Hi,
>
> Is there any uml linux patch that has implementations for functions of 
> set_thread_area and get_thread_area for um architecture? I am running 
> the uml linux kernel in a host that has tls and nptl-enabed, and I 
> would like to run some applications within the uml linux. But it 
> complains "cannot set up thread-local storage: set_thread_area failed 
> when setting up thread-local storage".
>
Unfortunately no one has one yet.  I'm working on getting TLS in SKAS 
mode to work but I don't have as much time as I'd like to work on it 
during the week.  I've got it started, so with a little luck I hope to 
have something complete in a week or two.

David Jeffery


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
