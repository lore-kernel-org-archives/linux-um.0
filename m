Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDVDc-0007kg-TR
 for linux-um@lists.infradead.org; Tue, 01 May 2018 13:21:31 +0000
From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: Question about process.c
Date: Tue, 01 May 2018 15:21:03 +0200
Message-ID: <1708862.d7yAjbcJLQ@blindfold>
In-Reply-To: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
References: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, linux-um@lists.infradead.org

Am Dienstag, 1. Mai 2018, 15:01:54 CEST schrieb Anton Ivanov:
> Hi all, hi Richard,
> 
> I have a question - is it really necessary to pass a "force" flag to a 
> tlb flush before doing a fork (in process.c)?

Where exactly?

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

