Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADFTJ-00078M-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 20:52:13 -0700
Received: from [212.55.154.26] (helo=sapo.pt)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ADFOe-00030P-I8
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 20:47:24 -0700
Message-ID: <3F97E59F.4050500@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml_switch
References: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
In-Reply-To: <20031023105524.88229.qmail@web20201.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 23 Oct 2003 15:28:47 +0100
To: Nelio Pereira <nelio_pereira@yahoo.com.br>
Cc: user-mode-linux-devel@lists.sourceforge.net



Nelio Pereira wrote:
> Hi list..

Hi!


> 
> I'm using UML to benchmark a distributed protocol
> (cluster membership service) on a virtual network. As
> a way of injecting faults, I thought about changing
> uml_switch so it would not forward every message it
> receives. Roughly speaking, it could deliver only a
> percentage of the messages. 
> 
> I would like to know where in the uml_switch code is
> the best place to do that. Actually, I'd like to
> intercept those messages in a place where I could know
> the sender and recipient IP of each message.
> 


I remember seeing, here, that someone ported uml_switch to python... 
Maybe that's easier to hack?

Hope this helps,
Nuno Silva


> Thanks,
> 
> Nelio
> 
> =====
> +------------------------------------------------------------------------+
>                        http://www.ime.usp.br/~nelio
> 
> Yahoo! Mail - o melhor webmail do Brasil
> http://mail.yahoo.com.br
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by OSDN developer relations
> Here's your chance to show off your extensive product knowledge
> We want to know what you know. Tell us and you have a chance to win $100
> http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
