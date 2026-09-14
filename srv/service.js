import cds from '@sap/cds'
import { Book } from '#cds-models/BookstoreService'
import { Books } from '#cds-models/BookstoreService'

export default class BookstoreService extends cds.ApplicationService {
  init() {

    this.on('addStock', Books, async (req) => {
      const bookId = req.params[0].ID
      console.log(bookId)

      await UPDATE(Books)
        .set({ stock: { '+=': 1 } })
        .where({ ID: bookId })
    })

//Change Publish Date
    this.on('changePublishDate', Books, async (req) => {
      const bookId = req.params[0].ID
      const newDateInput = req.data.newDate

      await UPDATE(Books)
        .set({ publishedAt: newDateInput })
        .where({ ID: bookId })
    })
//Change Status
this.on('changeStatus', Books, async (req) => {
      const bookId = req.params[0].ID
      const newStatus = req.data.newStatus
      const newStatusID = req.data.newStatusID

      await UPDATE(Books)
        .set({ Status_ID: newStatusID , Status_code: newStatus })
        .where({ ID: bookId })
    })




    this.before(['READ'], Book, async (req) => {
      console.log('Before READ Books')
    })

    this.on('READ', Book, async (req, next) => {
      return next()
    })

    this.after('READ', Book, (result, req) => {
      const books = Array.isArray(result) ? result : [result]

      for (const book of books) {
        if (book && book.genre_code === 'Fiction') {
          book.price = book.price * 0.8
        }
      }
    })

    return super.init()
  }
}