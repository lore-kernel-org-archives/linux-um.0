Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQ7Zo-0005Q7-5U
 for linux-um@lists.infradead.org; Tue, 05 Jun 2018 08:44:26 +0000
Date: Tue, 5 Jun 2018 11:43:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Fix initialization of vector queues in UML
Message-ID: <20180605084355.se5krnea6wrdmmez@mwanda>
References: <20180605082730.30919-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180605082730.30919-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard.weinberger@gmail.com, linux-um@lists.infradead.org

That's a good start but there are still issues:

   473          /* deallocate matching IOV structures including header buffs */
   474          if (qi->mmsg_vector != NULL) {
   475                  mmsg_vector = qi->mmsg_vector;
   476                  for (i = 0; i < qi->max_depth; i++) {
   477                          iov = mmsg_vector->msg_hdr.msg_iov;
   478                          if (iov != NULL) {
   479                                  if ((vp->header_size > 0) &&
   480                                          (iov->iov_base != NULL))
   481                                          kfree(iov->iov_base);
   482                                  kfree(iov);
   483                          }
   484                          mmsg_vector++;
   485                  }
   486                  kfree(qi->mmsg_vector);
   487          }


mmsg_vector is a pointer to within the result->mmsg_vector array.  It
starts at the begining and iterates through the whole array.  The
problem is that we maybe didn't initialize the last half of the array so
now iov is pointing to random memory.

regards,
dan carpenter



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

