Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMx7n-000858-Ng
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:30:40 +0000
Date: Wed, 14 Nov 2018 16:30:28 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
Message-ID: <20181114153028.GB28557@lst.de>
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: axboe@kernel.dk, richard@nod.at, linux-um@lists.infradead.org, hch@lst.de

Discards are defined to be hints.  So if your fileystems return
-EOPTNOTSUPP you just stop passing them to the file system and
complete them from ->queue_rq.

Write Zeroes isn't.  So if you really want to support it you
should manually write zeroes to the file as a fallback.  But do you
have a real use case for Write Zeroes to start with?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

