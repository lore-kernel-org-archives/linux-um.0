Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 22 Sep 2011 14:21:10 -0400 (EDT)
Message-Id: <20110922.142110.1470776655731016807.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAGZFCEHtyE1MutMmhKefFm9Xx5rri1j7DR7L=cFU3KUg7ejs4g@mail.gmail.com>
References: <CAGZFCEHtyE1MutMmhKefFm9Xx5rri1j7DR7L=cFU3KUg7ejs4g@mail.gmail.com>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] routing table error in 2.6.39 ..
To: ratheesh.ksz@gmail.com
Cc: netdev@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Date: Thu, 22 Sep 2011 21:25:47 +0530

> in 2.6.38 routing  table is  correct. But in 2.6.39 default gw appears
> on top of the routing table. same problem persist in 3.0.0 also.

You cannot depend upon the order in which routing table entries
are listed by the kernel.

The table internally is correct, and lookups will match using the
proper longest-matching-prefix algorithm.

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

