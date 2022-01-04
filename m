Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Mon, 3 Jan 2022 23:43:39 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
Message-ID: <YdP6qx0G7ICcBu3f@infradead.org>
References: <20220102070623.24009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220102070623.24009-1-rdunlap@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-rdma@vger.kernel.org, linux-um@lists.infradead.org

Yikes, this rdmavt code is completely fucked up and a very good example
why people should not use __user casts or random internal helpers.

The right fix is to remove this crap entirely, and if the rdmavt
maintainer think that they absolutely need a non-temporal memcpy they
need to work to add a core API for it.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

