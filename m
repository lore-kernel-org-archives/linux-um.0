Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: cleanup ubd gendisk registration
Date: Mon, 14 Jun 2021 08:07:57 +0200
Message-Id: <20210614060759.3965724-1-hch@lst.de>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org

Hi all,

this series sits on top of Jens' for-5.14/block branch and tries to
convert ubd to the new gendisk and request_queue registration helpers.
As part of that I found that the ide emulation code currently registers
two gendisk for a request_queue which leads to a bunch of problems we've
avoided in other drivers (only the mmc subsystem has a similar issue).
Given that the legacy IDE driver isn't practically used any more and
modern userspace doesn't hard code specific block drivers, so I think
we can just drop it.  Let me know if this is ok.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

