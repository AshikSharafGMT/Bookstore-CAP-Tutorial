import cds from '@sap/cds'
import { Book } from '#cds-models/BookstoreService'

export default class BookstoreService extends cds.ApplicationService {
  init() {
    this.before(['READ'], Book, async req => {
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